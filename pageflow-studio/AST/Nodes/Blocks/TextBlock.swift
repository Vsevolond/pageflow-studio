//
//  TextBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 08.12.2025.
//

import Foundation

struct TextBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let content: TextContent
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try content.validate(with: storage)
        try modifiers.validate(with: storage)
    }
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
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .textLayout(let textLayoutModifiers):
                try textLayoutModifiers.validate(with: storage)
                
            case .textEditing(let textEditingModifiers):
                try textEditingModifiers.validate(with: storage)
                
            case .font(let fontModifiers):
                try fontModifiers.validate(with: storage)
                
            case .frame(let frameModifiers):
                try frameModifiers.validate(with: storage)
                
            case .layout(let layoutModifiers):
                try layoutModifiers.validate(with: storage)
                
            case .alignment(let alignmentModifiers):
                try alignmentModifiers.validate(with: storage)
                
            case .foreground(let foregroundModifiers):
                try foregroundModifiers.validate(with: storage)
                
            case .background(let backgroundModifiers):
                try backgroundModifiers.validate(with: storage)
            }
        }
    }
}
