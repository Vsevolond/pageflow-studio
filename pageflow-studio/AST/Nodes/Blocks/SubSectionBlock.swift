//
//  SubSectionBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct SubSectionBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let title: [TextFragment]
    let content: [Content]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try title.validate(with: storage)
        try content.validate(with: storage)
    }
}

// MARK: - Extensions

extension SubSectionBlock {
    
    // MARK: - Content
    
    enum Content: ASTNode {
        
        // MARK: - Cases
        
        case newPage(SubSectionNewPageBlock)
        case content(BaseContent)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .newPage(let subSectionNewPageBlock):
                subSectionNewPageBlock.range
                
            case .content(let baseContent):
                baseContent.range
            }
        }
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .newPage(let subSectionNewPageBlock):
                try subSectionNewPageBlock.validate(with: storage)
                
            case .content(let baseContent):
                try baseContent.validate(with: storage)
            }
        }
    }
}
