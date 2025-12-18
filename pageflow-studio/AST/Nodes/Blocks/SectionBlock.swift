//
//  SectionBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct SectionBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let title: [TextFragment]
    let content: [Content]
    let range: NSRange
    
    // MARK: - Internal Properties
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try title.validate(with: storage)
        try content.validate(with: storage)
    }
}

// MARK: - Extensions

extension SectionBlock {
    
    // MARK: - Content
    
    enum Content: ASTNode {
        
        // MARK: - Cases
        
        case newPage(SectionNewPageBlock)
        case subSection(SubSectionBlock)
        case content(BaseContent)
        
        // MARK: - Internal Properties
        
        var range: NSRange {
            switch self {
            case .newPage(let sectionNewPageBlock):
                sectionNewPageBlock.range
                
            case .subSection(let subSectionBlock):
                subSectionBlock.range
                
            case .content(let baseContent):
                baseContent.range
            }
        }
        
        // MARK: - Internal Methods
        
        func validate(with storage: ASTStorage) throws(ASTError) {
            switch self {
            case .newPage(let sectionNewPageBlock):
                try sectionNewPageBlock.validate(with: storage)
                
            case .subSection(let subSectionBlock):
                try subSectionBlock.validate(with: storage)
                
            case .content(let baseContent):
                try baseContent.validate(with: storage)
            }
        }
    }
}
