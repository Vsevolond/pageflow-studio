//
//  NewPageBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 08.12.2025.
//

import Foundation

struct NewPageBlock<Content: ASTNode>: ASTNode {
    
    // MARK: - Internal Properties
    
    let content: [Content]
    let modifiers: [DefaultNewPageBlock.Modifier]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try content.validate(with: storage)
        try modifiers.validate(with: storage)
    }
}

// MARK: - Extensions

extension NewPageBlock {
    
    // MARK: - Type Entities
    
    enum Modifier: ASTNode {
        
        // MARK: - Cases
        
        case page(PageModifiers)
        case inset(InsetModifiers)
        
        // MARK: - Interanal Properties
        
        var range: NSRange {
            switch self {
            case .page(let pageModifiers):
                pageModifiers.range
                
            case .inset(let insetModifiers):
                insetModifiers.range
            }
        }
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .page(let pageModifiers):
                try pageModifiers.validate(with: storage)
                
            case .inset(let insetModifiers):
                try insetModifiers.validate(with: storage)
            }
        }
    }
}
