//
//  TextContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 25.02.2026.
//

import Foundation

struct TextContent: ASTNode {
    
    // MARK: - Internal Properties
    
    let fragments: [TextFragment]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try fragments.validate(with: storage)
    }
}
