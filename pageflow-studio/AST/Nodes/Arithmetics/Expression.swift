//
//  Expression.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

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
}
