//
//  ImageElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import AppKit
import SwiftUI

struct ImageElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let name: FileName
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try name.validate(with: storage)
        try modifiers.validate(with: storage)
    }
}

// MARK: - Extensions

extension ImageElement {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case frame(FrameModifiers)
        case layout(LayoutModifiers)
        case alignment(AlignmentModifiers)
        case figure(FigureModifiers)
        case subfigure(SubfigureModifiers)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .frame(let frameModifiers):
                frameModifiers.range
                
            case .layout(let layoutModifiers):
                layoutModifiers.range
                
            case .alignment(let alignmentModifiers):
                alignmentModifiers.range
                
            case .figure(let figureModifiers):
                figureModifiers.range
                
            case .subfigure(let subfigureModifiers):
                subfigureModifiers.range
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
                
            case .figure(let figureModifiers):
                try figureModifiers.validate(with: storage)
                
            case .subfigure(let subfigureModifiers):
                try subfigureModifiers.validate(with: storage)
            }
        }
    }
}

extension ImageElement {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var width: CGFloat?
        var height: CGFloat?
        var padding: EdgeInsets
        var offset: CGSize
        var alignment: Alignment
        var enumerated: Bool
        var caption: TextContent?
        var subfigure: Bool
        
        init(
            width: CGFloat? = nil,
            height: CGFloat? = nil,
            padding: EdgeInsets = .zero,
            offset: CGSize = .zero,
            alignment: Alignment = .center,
            enumerated: Bool = false,
            caption: TextContent? = nil,
            subfigure: Bool = false
        ) {
            self.width = width
            self.height = height
            self.padding = padding
            self.offset = offset
            self.alignment = alignment
            self.enumerated = enumerated
            self.caption = caption
            self.subfigure = subfigure
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
                
            case .figure(let figureModifiers):
                switch figureModifiers {
                case .enumerated(let enumeratedModifier):
                    parameters.enumerated = enumeratedModifier.value
                    
                case .caption(let captionModifier):
                    parameters.caption = captionModifier.value
                }
                
            case .subfigure(let subfigureModifiers):
                switch subfigureModifiers {
                case .subfigure(let subfigureModifier):
                    parameters.subfigure = subfigureModifier.value
                }
            }
        }
        
        return parameters
    }
}
