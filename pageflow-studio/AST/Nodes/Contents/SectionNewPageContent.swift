//
//  SectionNewPageContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

typealias SectionNewPageBlock = NewPageBlock<SectionNewPageContent>

enum SectionNewPageContent: ASTNode {
    
    // MARK: - Cases
    
    case subSection(SubSectionBlock)
    case content(BaseContent)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .subSection(let subSectionBlock):
            subSectionBlock.range
            
        case .content(let baseContent):
            baseContent.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .subSection(let subSectionBlock):
            try subSectionBlock.validate(with: storage)
            
        case .content(let baseContent):
            try baseContent.validate(with: storage)
        }
    }
}
