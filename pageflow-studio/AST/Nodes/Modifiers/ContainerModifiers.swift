//
//  ContainerModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum ContainerModifiers: ASTNode {
    
    // MARK: - Cases
    
    case spacing(SpacingModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .spacing(let spacingModifier):
            spacingModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .spacing(let spacingModifier):
            try spacingModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct SpacingModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
        
        guard value.isMeasured else {
            throw .invalid(expression: value)
        }
    }
}
