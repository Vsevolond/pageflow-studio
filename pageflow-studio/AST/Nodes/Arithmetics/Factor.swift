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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension Factor: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        switch self {
        case .unary(let unaryFactor):
            unaryFactor.isMeasured
            
        case .primary(let primaryFactor):
            primaryFactor.isMeasured
        }
    }
    
    var points: CGFloat {
        switch self {
        case .unary(let unaryFactor):
            unaryFactor.points
            
        case .primary(let primaryFactor):
            primaryFactor.points
        }
    }
}
