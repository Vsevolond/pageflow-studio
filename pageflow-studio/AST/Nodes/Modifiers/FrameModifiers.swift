//
//  FrameModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FrameModifiers: ASTNode {
    
    // MARK: - Cases
    
    case width(WidthModifier)
    case height(HeightModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .width(let widthModifier):
            widthModifier.range
            
        case .height(let heightModifier):
            heightModifier.range
        }
    }
}

// MARK: - Modifiers

struct WidthModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
}

struct HeightModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
}
