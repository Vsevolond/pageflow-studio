//
//  DefaultNewPageContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

typealias DefaultNewPageBlock = NewPageBlock<DefaultNewPageContent>

enum DefaultNewPageContent: ASTNode {
    
    // MARK: - Cases
    
    case section(SectionBlock)
    case content(BaseContent)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .section(let sectionBlock):
            sectionBlock.range
            
        case .content(let baseContent):
            baseContent.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .section(let sectionBlock):
            try sectionBlock.validate(with: storage)
            
        case .content(let baseContent):
            try baseContent.validate(with: storage)
        }
    }
}
