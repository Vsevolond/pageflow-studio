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
    }
}
