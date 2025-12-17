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
}
