//
//  PrimaryFactor.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum PrimaryFactor: ASTNode {
    
    // MARK: - Cases
    
    case expression(Expression)
    case constant(Constant)
    case number(Number)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .expression(let expression):
            expression.range
            
        case .constant(let constant):
            constant.range
            
        case .number(let number):
            number.range
        }
    }
}
