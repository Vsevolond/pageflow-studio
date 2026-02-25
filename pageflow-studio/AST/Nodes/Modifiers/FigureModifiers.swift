//
//  FigureModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FigureModifiers: ASTNode {
    
    // MARK: - Cases
    
    case enumerated(EnumeratedModifier)
    case caption(CaptionModifier)
    
    // MARK: - Internal Modifier
    
    var range: NSRange {
        switch self {
        case .enumerated(let enumeratedModifier):
            enumeratedModifier.range
            
        case .caption(let captionModifier):
            captionModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .enumerated(let enumeratedModifier):
            try enumeratedModifier.validate(with: storage)
            
        case .caption(let captionModifier):
            try captionModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct EnumeratedModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

struct CaptionModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: TextContent
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}
