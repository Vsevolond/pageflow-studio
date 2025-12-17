//
//  DividerElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct DividerElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let thickness: Expression
    let modifiers: [Modifier]
    let range: NSRange
}

// MARK: - Extensions

extension DividerElement {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case frame(FrameModifiers)
        case layout(LayoutModifiers)
        case alignment(AlignmentModifiers)
        case foreground(ForegroundModifiers)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .frame(let frameModifiers):
                frameModifiers.range
                
            case .layout(let layoutModifiers):
                layoutModifiers.range
                
            case .alignment(let alignmentModifiers):
                alignmentModifiers.range
                
            case .foreground(let foregroundModifiers):
                foregroundModifiers.range
            }
        }
    }
}
