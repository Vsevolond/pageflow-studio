//
//  BackgroundModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum BackgroundModifiers: ASTNode {
    
    // MARK: - Cases
    
    case background(BackgroundModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .background(let backgroundModifier):
            backgroundModifier.range
        }
    }
}

// MARK: - Modifiers

struct BackgroundModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: ColorType
    let range: NSRange
}
