//
//  UnaryFactor.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct UnaryFactor: ASTNode {
    
    // MARK: - Internal Properties
    
    let operation: AddOperation
    let value: PrimaryFactor
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension UnaryFactor: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        value.isMeasured
    }
    
    var points: CGFloat {
        switch operation.value {
        case .addition: value.points
        case .substraction: -value.points
        }
    }
}
