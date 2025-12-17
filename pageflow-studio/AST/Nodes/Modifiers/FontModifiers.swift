//
//  FontModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FontModifiers: ASTNode {
    
    // MARK: - Cases
    
    case fontSize(FontSizeModifier)
    case fontStyle(FontStyleModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .fontSize(let fontSizeModifier):
            fontSizeModifier.range
            
        case .fontStyle(let fontStyleModifier):
            fontStyleModifier.range
        }
    }
}

// MARK: - Modifiers

struct FontSizeModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: FontSizeType
    let range: NSRange
}

struct FontStyleModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: FontStyleType
    let range: NSRange
}
