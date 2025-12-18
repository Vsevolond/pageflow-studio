//
//  Term.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

indirect enum Term: ASTNode {
    
    // MARK: - Cases
    
    case factor(Factor)
    case multiply(Term, MulOperation, Factor)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case let .factor(factor):
            factor.range
            
        case let .multiply(term, mulOperation, factor):
            NSRange(
                location: term.range.location,
                length: term.range.length + mulOperation.range.length + factor.range.length
            )
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .factor(let factor):
            try factor.validate(with: storage)
            
        case .multiply(let term, let mulOperation, let factor):
            try term.validate(with: storage)
            try factor.validate(with: storage)
            
            switch mulOperation.value {
            case .multiplication where term.isMeasured && factor.isMeasured:
                throw .invalidMul(operation: mulOperation)
                
            case .division where factor.isMeasured || factor.points == .zero:
                throw .invalidMul(operation: mulOperation)
                
            default:
                return
            }
        }
    }
}

// MARK: - Extensions

extension Term: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        switch self {
        case let .factor(factor):
            factor.isMeasured
            
        case let .multiply(term, _, factor):
            (term.isMeasured && !factor.isMeasured) ||
            (!term.isMeasured && factor.isMeasured)
        }
    }
    
    var points: CGFloat {
        switch self {
        case .factor(let factor):
            factor.points
            
        case .multiply(let term, let mulOperation, let factor):
            switch mulOperation.value {
            case .multiplication:
                term.points * factor.points
                
            case .division:
                factor.points == .zero ? .zero : (term.points / factor.points)
            }
        }
    }
}
