//
//  TextBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 08.12.2025.
//

import Foundation

struct TextBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let fragments: [TextFragment]
    let modifiers: [Modifier]
    let range: NSRange
}

// MARK: - Extensions

extension TextBlock {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case textLayout(TextLayoutModifiers)
        case textEditing(TextEditingModifiers)
        case font(FontModifiers)
        case frame(FrameModifiers)
        case layout(LayoutModifiers)
        case alignment(AlignmentModifiers)
        case foreground(ForegroundModifiers)
        case background(BackgroundModifiers)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .textLayout(let textLayoutModifiers):
                textLayoutModifiers.range
                
            case .textEditing(let textEditingModifiers):
                textEditingModifiers.range
                
            case .frame(let frameModifiers):
                frameModifiers.range
                
            case .font(let fontModifiers):
                fontModifiers.range
                
            case .layout(let layoutModifiers):
                layoutModifiers.range
                
            case .alignment(let alignmentModifiers):
                alignmentModifiers.range
                
            case .foreground(let foregroundModifiers):
                foregroundModifiers.range
                
            case .background(let backgroundModifiers):
                backgroundModifiers.range
            }
        }
    }
}
