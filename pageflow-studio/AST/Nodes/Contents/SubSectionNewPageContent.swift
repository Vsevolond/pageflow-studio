//
//  SubSectionNewPageContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

typealias SubSectionNewPageBlock = NewPageBlock<SubSectionNewPageContent>

enum SubSectionNewPageContent: ASTNode {
    
    // MARK: - Cases
    
    case content(BaseContent)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .content(let baseContent):
            baseContent.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .content(let baseContent):
            try baseContent.validate(with: storage)
        }
    }
}
