//
//  NewPageBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 08.12.2025.
//

import SwiftUI

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

extension NewPageBlock {
    
    // MARK: - Type Entities
    
    struct Parameters {
        var header: TextContent?
        var footer: TextContent?
        var insets: EdgeInsets
        
        init(
            header: TextContent? = nil,
            footer: TextContent? = nil,
            insets: EdgeInsets = .zero
        ) {
            self.header = header
            self.footer = footer
            self.insets = insets
        }
    }
    
    // MARK: - Internal Properties
    
    var parameters: Parameters {
        var parameters = Parameters()
        
        for modifier in modifiers {
            switch modifier {
            case .page(let pageModifiers):
                switch pageModifiers {
                case .header(let headerModifier):
                    parameters.header = headerModifier.value
                    
                case .footer(let footerModifier):
                    parameters.footer = footerModifier.value
                }
                
            case .inset(let insetModifiers):
                switch insetModifiers {
                case .margin(let marginModifier):
                    parameters.insets.set(
                        marginModifier.rawValue,
                        for: marginModifier.rawEdge
                    )
                }
            }
        }
        
        return parameters
    }
}
