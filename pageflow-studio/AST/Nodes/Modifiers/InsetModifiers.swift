//
//  InsetModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum InsetModifiers: ASTNode {
    
    // MARK: - Cases
    
    case margin(MarginModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .margin(let marginModifier):
            marginModifier.range
        }
    }
}

// MARK: - Modifiers

struct MarginModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let edge: EdgeType
    let value: Expression
    let range: NSRange
}
