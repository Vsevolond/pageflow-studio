//
//  ZStackBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import AppKit
import SwiftUI

struct ZStackBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let content: [BaseContent]
    let modifiers: [Modifier]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try content.validate(with: storage)
        try modifiers.validate(with: storage)
    }
}

// MARK: - Extensions

extension ZStackBlock {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case frame(FrameModifiers)
        case layout(LayoutModifiers)
        case inset(InsetModifiers)
        case container(ContainerModifiers)
        case figure(FigureModifiers)
        case subfigure(SubfigureModifiers)
        case alignment(AlignmentModifiers)
        case background(BackgroundModifiers)
        case stackAlignment(ZAlignmentModifier)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .frame(let frameModifiers):
                frameModifiers.range
                
            case .layout(let layoutModifiers):
                layoutModifiers.range
                
            case .inset(let insetModifiers):
                insetModifiers.range
                
            case .container(let containerModifiers):
                containerModifiers.range
                
            case .figure(let figureModifiers):
                figureModifiers.range
                
            case .subfigure(let subfigureModifiers):
                subfigureModifiers.range
                
            case .alignment(let alignmentModifiers):
                alignmentModifiers.range
                
            case .background(let backgroundModifiers):
                backgroundModifiers.range
                
            case .stackAlignment(let zAlignmentModifier):
                zAlignmentModifier.range
            }
        }
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .frame(let frameModifiers):
                try frameModifiers.validate(with: storage)
                
            case .layout(let layoutModifiers):
                try layoutModifiers.validate(with: storage)
                
            case .inset(let insetModifiers):
                try insetModifiers.validate(with: storage)
                
            case .container(let containerModifiers):
                try containerModifiers.validate(with: storage)
                
            case .figure(let figureModifiers):
                try figureModifiers.validate(with: storage)
                
            case .subfigure(let subfigureModifiers):
                try subfigureModifiers.validate(with: storage)
                
            case .alignment(let alignmentModifiers):
                try alignmentModifiers.validate(with: storage)
                
            case .background(let backgroundModifiers):
                try backgroundModifiers.validate(with: storage)
                
            case .stackAlignment(let zAlignmentModifier):
                try zAlignmentModifier.validate(with: storage)
            }
        }
    }
}

extension ZStackBlock {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var width: CGFloat?
        var height: CGFloat?
        var padding: EdgeInsets
        var insets: EdgeInsets
        var offset: CGSize
        var spacing: CGFloat
        var enumerated: Bool
        var caption: TextContent?
        var subfigure: Bool
        var alignment: Alignment
        var stackAlignment: Alignment
        var backgroundColor: NSColor
        
        init(
            width: CGFloat? = nil,
            height: CGFloat? = nil,
            padding: EdgeInsets = .zero,
            insets: EdgeInsets = .zero,
            offset: CGSize = .zero,
            spacing: CGFloat = 10,
            enumerated: Bool = false,
            caption: TextContent? = nil,
            subfigure: Bool = false,
            alignment: Alignment = .center,
            stackAlignment: Alignment = .center,
            backgroundColor: NSColor = .clear
        ) {
            self.width = width
            self.height = height
            self.padding = padding
            self.insets = insets
            self.offset = offset
            self.spacing = spacing
            self.enumerated = enumerated
            self.caption = caption
            self.subfigure = subfigure
            self.alignment = alignment
            self.stackAlignment = stackAlignment
            self.backgroundColor = backgroundColor
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
                
            case .inset(let insetModifiers):
                switch insetModifiers {
                case .margin(let marginModifier):
                    parameters.insets.set(
                        marginModifier.rawValue,
                        for: marginModifier.rawEdge
                    )
                }
                
            case .container(let containerModifiers):
                switch containerModifiers {
                case .spacing(let spacingModifier):
                    parameters.spacing = spacingModifier.rawValue
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
                
            case .alignment(let alignmentModifiers):
                switch alignmentModifiers {
                case .layout(let layoutModifier):
                    parameters.alignment = layoutModifier.rawValue
                }
                
            case .background(let backgroundModifiers):
                switch backgroundModifiers {
                case .background(let backgroundModifier):
                    parameters.backgroundColor = backgroundModifier.rawValue
                }
                
            case .stackAlignment(let zAlignmentModifier):
                parameters.stackAlignment = zAlignmentModifier.rawValue
            }
        }
        
        return parameters
    }
}
