//
//  PageModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum PageModifiers: ASTNode {
    
    // MARK: - Cases
    
    case header(HeaderModifier)
    case footer(FooterModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .header(let headerModifier):
            headerModifier.range
            
        case .footer(let footerModifier):
            footerModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .header(let headerModifier):
            try headerModifier.validate(with: storage)
            
        case .footer(let footerModifier):
            try footerModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct HeaderModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: TextContent
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct FooterModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: TextContent
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}
