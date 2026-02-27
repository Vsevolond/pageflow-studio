//
//  TextBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 08.12.2025.
//

import AppKit
import SwiftUI

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

extension TextBlock {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var textAlignment: NSTextAlignment
        var lineSpacing: CGFloat?
        var underline: (style: NSUnderlineStyle, color: NSColor)?
        var strikethrough: (style: NSUnderlineStyle, color: NSColor)?
        var fontSize: CGFloat
        var font: NSFont
        var foregroundColor: NSColor
        var backgroundColor: NSColor
        
        var width: CGFloat?
        var height: CGFloat?
        var alignment: Alignment
        var padding: EdgeInsets
        var offset: CGSize
        
        init(
            width: CGFloat? = nil,
            height: CGFloat? = nil,
            textAlignment: NSTextAlignment = .left,
            lineSpacing: CGFloat? = nil,
            underline: (style: NSUnderlineStyle, color: NSColor)? = nil,
            strikethrough: (style: NSUnderlineStyle, color: NSColor)? = nil,
            fontSize: CGFloat = 12,
            font: NSFont = NSFont.latex(size: 12),
            foregroundColor: NSColor = .black,
            backgroundColor: NSColor = .clear,
            alignment: Alignment = .leading,
            padding: EdgeInsets = .zero,
            offset: CGSize = .zero
        ) {
            self.width = width
            self.height = height
            self.textAlignment = textAlignment
            self.lineSpacing = lineSpacing
            self.underline = underline
            self.strikethrough = strikethrough
            self.fontSize = fontSize
            self.font = font
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
            self.alignment = alignment
            self.padding = padding
            self.offset = offset
        }
    }
    
    // MARK: - Internal Properties
    
    var parameters: Parameters {
        var parameters = Parameters()
        
        for modifier in modifiers {
            switch modifier {
            case .textLayout(let textLayoutModifiers):
                switch textLayoutModifiers {
                case .textAlignment(let textAlignmentModifier):
                    parameters.textAlignment = textAlignmentModifier.rawValue
                    
                case .lineSpacing(let lineSpacingModifier):
                    parameters.lineSpacing = lineSpacingModifier.rawValue
                }
                
            case .textEditing(let textEditingModifiers):
                switch textEditingModifiers {
                case .underline(let underlineModifier):
                    parameters.underline = (
                        underlineModifier.rawLine,
                        underlineModifier.rawColor
                    )
                    
                case .strikethrough(let strikethroughModifier):
                    parameters.strikethrough = (
                        strikethroughModifier.rawLine,
                        strikethroughModifier.rawColor
                    )
                }
                
            case .font(let fontModifiers):
                switch fontModifiers {
                case .fontSize(let fontSizeModifier):
                    parameters.fontSize = fontSizeModifier.rawValue
                    
                case .fontStyle(let fontStyleModifier):
                    parameters.font = NSFont.latex(
                        size: parameters.fontSize,
                        style: fontStyleModifier.rawValue
                    )
                }
                
            case .frame(let frameModifiers):
                switch frameModifiers {
                case .width(let widthModifier):
                    parameters.width = widthModifier.rawValue
                    
                case .height(let heightModifier):
                    parameters.height = heightModifier.rawValue
                }
                
            case .layout(let layoutModifiers):
                switch layoutModifiers {
                case .padding(let paddingModifier):
                    parameters.padding.set(
                        paddingModifier.rawValue,
                        for: paddingModifier.rawEdge
                    )
                    
                case .offset(let offsetModifier):
                    parameters.offset.set(
                        offsetModifier.rawValue,
                        for: offsetModifier.rawAxis
                    )
                }
                
            case .alignment(let alignmentModifiers):
                switch alignmentModifiers {
                case .layout(let layoutModifier):
                    parameters.alignment = layoutModifier.rawValue
                }
                
            case .foreground(let foregroundModifiers):
                switch foregroundModifiers {
                case .tint(let tintModifier):
                    parameters.foregroundColor = tintModifier.rawValue
                }
                
            case .background(let backgroundModifiers):
                switch backgroundModifiers {
                case .background(let backgroundModifier):
                    parameters.backgroundColor = backgroundModifier.rawValue
                }
            }
        }
        
        return parameters
    }
}
