//
//  Factor.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum Factor: ASTNode {
    
    // MARK: - Cases
    
    case unary(UnaryFactor)
    case primary(PrimaryFactor)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .unary(let unaryFactor):
            unaryFactor.range
            
        case .primary(let primaryFactor):
            primaryFactor.range
        }
    }
}
