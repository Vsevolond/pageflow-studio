//
//  ListingElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 10.12.2025.
//

import Foundation

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
