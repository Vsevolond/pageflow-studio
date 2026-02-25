//
//  Expression.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

// MARK: - Expression

indirect enum Expression: ASTNode {
    
    // MARK: - Cases
    
    case term(Term)
    case binary(Expression, AddOperation, Term)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case let .term(term):
            term.range
            
        case let .binary(expression, addOperation, term):
            NSRange(
                location: expression.range.location,
                length: expression.range.length + addOperation.range.length + term.range.length
            )
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .term(let term):
            try term.validate(with: storage)
            
        case .binary(let expression, let addOperation, let term):
            try expression.validate(with: storage)
            try term.validate(with: storage)
            
            guard expression.isMeasured && term.isMeasured else {
                throw .invalidAdd(operation: addOperation)
            }
        }
    }
}

// MARK: - Extensions

extension Expression: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        switch self {
        case let .term(term):
            term.isMeasured
            
        case let .binary(expression, _, term):
            expression.isMeasured && term.isMeasured
        }
    }
    
    var points: CGFloat {
        switch self {
        case .term(let term):
            term.points
            
        case .binary(let expression, let addOperation, let term):
            switch addOperation.value {
            case .addition:
                expression.points + term.points
                
            case .substraction:
                expression.points - term.points
            }
        }
    }
}
