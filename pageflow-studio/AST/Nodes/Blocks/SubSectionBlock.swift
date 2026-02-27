//
//  SubSectionBlock.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct SubSectionBlock: ASTNode {
    
    // MARK: - Internal Properties
    
    let title: TextContent
    let content: [SectionBlock.Content]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try title.validate(with: storage)
        try content.validate(with: storage)
    }
}
