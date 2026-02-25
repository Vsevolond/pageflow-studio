//
//  VStackBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct VStackBlock: ASTNode {
    
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

extension VStackBlock {
    
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
        case stackAlignment(VAlignmentModifier)
        
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
                
            case .stackAlignment(let vAlignmentModifier):
                vAlignmentModifier.range
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
                
            case .stackAlignment(let vAlignmentModifier):
                try vAlignmentModifier.validate(with: storage)
            }
        }
    }
}
