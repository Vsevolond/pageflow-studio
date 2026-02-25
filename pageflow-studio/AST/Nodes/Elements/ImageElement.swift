//
//  ImageElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

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
