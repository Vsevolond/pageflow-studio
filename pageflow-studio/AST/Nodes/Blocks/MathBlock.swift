//
//  MathBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct MathBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let fragments: [MathFragment]
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try fragments.validate(with: storage)
        try modifiers.validate(with: storage)
    }
}

// MARK: - Extensions

extension MathBlock {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case textLayout(TextLayoutModifiers)
        case font(FontModifiers)
        case frame(FrameModifiers)
        case layout(LayoutModifiers)
        case alignment(AlignmentModifiers)
        case inset(InsetModifiers)
        case foreground(ForegroundModifiers)
        case background(BackgroundModifiers)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .textLayout(let textLayoutModifiers):
                textLayoutModifiers.range
                
            case .font(let fontModifiers):
                fontModifiers.range
                
            case .frame(let frameModifiers):
                frameModifiers.range
                
            case .layout(let layoutModifiers):
                layoutModifiers.range
                
            case .alignment(let alignmentModifiers):
                alignmentModifiers.range
                
            case .inset(let insetModifiers):
                insetModifiers.range
                
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
                
            case .font(let fontModifiers):
                try fontModifiers.validate(with: storage)
                
            case .frame(let frameModifiers):
                try frameModifiers.validate(with: storage)
                
            case .layout(let layoutModifiers):
                try layoutModifiers.validate(with: storage)
                
            case .alignment(let alignmentModifiers):
                try alignmentModifiers.validate(with: storage)
                
            case .inset(let insetModifiers):
                try insetModifiers.validate(with: storage)
                
            case .foreground(let foregroundModifiers):
                try foregroundModifiers.validate(with: storage)
                
            case .background(let backgroundModifiers):
                try backgroundModifiers.validate(with: storage)
            }
        }
    }
}
