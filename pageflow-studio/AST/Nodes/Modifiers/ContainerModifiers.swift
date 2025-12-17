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
}

// MARK: - Modifiers

struct SpacingModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
}
