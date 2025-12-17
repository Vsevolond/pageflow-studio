//
//  ForegroundModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum ForegroundModifiers: ASTNode {
    
    // MARK: - Cases
    
    case tint(TintModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .tint(let tintModifier):
            tintModifier.range
        }
    }
}

// MARK: - Modifiers

struct TintModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: ColorType
    let range: NSRange
}
