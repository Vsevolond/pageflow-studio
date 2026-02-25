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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension PrimaryFactor: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        switch self {
        case .expression(let expression):
            expression.isMeasured
            
        case .constant(let constant):
            constant.isMeasured
            
        case .number(let number):
            number.isMeasured
        }
    }
    
    var points: CGFloat {
        switch self {
        case .expression(let expression):
            expression.points
            
        case .constant(let constant):
            constant.points
            
        case .number(let number):
            number.points
        }
    }
}
