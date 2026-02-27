//
//  DividerElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import AppKit
import SwiftUI

struct DividerElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let thickness: Expression?
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Initializers
    
    init(
        thickness: Expression? = nil,
        modifiers: [Modifier],
        range: NSRange
    ) {
        self.thickness = thickness
        self.modifiers = modifiers
        self.range = range
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        if let thickness {
            try thickness.validate(with: storage)
        }
        
        try modifiers.validate(with: storage)
    }
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
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .frame(let frameModifiers):
                try frameModifiers.validate(with: storage)
                
            case .layout(let layoutModifiers):
                try layoutModifiers.validate(with: storage)
                
            case .alignment(let alignmentModifiers):
                try alignmentModifiers.validate(with: storage)
                
            case .foreground(let foregroundModifiers):
                try foregroundModifiers.validate(with: storage)
            }
        }
    }
}

extension DividerElement {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var width: CGFloat?
        var height: CGFloat?
        var padding: EdgeInsets
        var offset: CGSize
        var alignment: Alignment
        var foregroundColor: NSColor?
        
        init(
            width: CGFloat? = nil,
            height: CGFloat? = nil,
            padding: EdgeInsets = .zero,
            offset: CGSize = .zero,
            alignment: Alignment = .center,
            foregroundColor: NSColor? = nil
        ) {
            self.width = width
            self.height = height
            self.padding = padding
            self.offset = offset
            self.alignment = alignment
            self.foregroundColor = foregroundColor
        }
    }
    
    // MARK: - Internal Properties
    
    var parameters: Parameters {
        var parameters = Parameters()
        
        for modifier in modifiers {
            switch modifier {
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
            }
        }
        
        return parameters
    }
}
