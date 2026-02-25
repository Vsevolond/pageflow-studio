//
//  Element.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

enum Element: ASTNode {
    
    // MARK: - Cases
    
    case newPage(DefaultNewPageBlock)
    case section(SectionBlock)
    case content(BaseContent)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .newPage(let defaultNewPageBlock):
            defaultNewPageBlock.range
            
        case .section(let sectionBlock):
            sectionBlock.range
            
        case .content(let baseContent):
            baseContent.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .newPage(let defaultNewPageBlock):
            try defaultNewPageBlock.validate(with: storage)
            
        case .section(let sectionBlock):
            try sectionBlock.validate(with: storage)
            
        case .content(let baseContent):
            try baseContent.validate(with: storage)
        }
    }
}
