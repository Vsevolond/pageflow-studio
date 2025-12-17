//
//  ZStackBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct ZStackBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let content: [BaseContent]
    let modifiers: [Modifier]
    let range: NSRange
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
    }
}
