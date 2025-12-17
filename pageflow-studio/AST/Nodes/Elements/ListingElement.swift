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
    }
}
