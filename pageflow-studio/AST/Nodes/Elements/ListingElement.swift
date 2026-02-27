//
//  ListingElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 10.12.2025.
//

import AppKit
import SwiftUI
import Rearrange

struct ListingElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let name: FileName
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Internal Properties
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try name.validate(with: storage)
        try modifiers.validate(with: storage)
    }
}

// MARK: - Extensions

extension ListingElement {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case code(CodeModifiers)
        case font(FontModifiers)
        case figure(FigureModifiers)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .code(let codeModifiers):
                codeModifiers.range
                
            case .font(let fontModifiers):
                fontModifiers.range
                
            case .figure(let figureModifiers):
                figureModifiers.range
            }
        }
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .code(let codeModifiers):
                try codeModifiers.validate(with: storage)
                
            case .font(let fontModifiers):
                try fontModifiers.validate(with: storage)
                
            case .figure(let figureModifiers):
                try figureModifiers.validate(with: storage)
            }
        }
    }
}

extension ListingElement {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var language: String?
        var style: String?
        var frame: CodeFrameType?
        var numbers: Bool
        var fontSize: CGFloat
        var font: NSFont
        var enumerated: Bool
        var caption: TextContent?
        
        init(
            language: String? = nil,
            style: String? = nil,
            frame: CodeFrameType? = nil,
            numbers: Bool = true,
            fontSize: CGFloat = 10,
            font: NSFont = NSFont.latex(size: 10, style: .monospaced),
            enumerated: Bool = false,
            caption: TextContent? = nil
        ) {
            self.language = language
            self.style = style
            self.frame = frame
            self.numbers = numbers
            self.fontSize = fontSize
            self.font = font
            self.enumerated = enumerated
            self.caption = caption
        }
    }
    
    // MARK: - Internal Properties
    
    var parameters: Parameters {
        var parameters = Parameters()
        
        for modifier in modifiers {
            switch modifier {
            case .code(let codeModifiers):
                switch codeModifiers {
                case .language(let codeLanguageModifier):
                    parameters.language = codeLanguageModifier.rawValue
                    
                case .style(let codeStyleModifier):
                    parameters.style = codeStyleModifier.rawValue
                    
                case .frame(let codeFrameModifier):
                    parameters.frame = codeFrameModifier.value
                    
                case .numbers(let codeNumbersModifier):
                    parameters.numbers = codeNumbersModifier.value
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
                
            case .figure(let figureModifiers):
                switch figureModifiers {
                case .enumerated(let enumeratedModifier):
                    parameters.enumerated = enumeratedModifier.value
                    
                case .caption(let captionModifier):
                    parameters.caption = captionModifier.value
                }
            }
        }
        
        return parameters
    }
}
