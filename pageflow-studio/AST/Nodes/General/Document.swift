//
//  Document.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct Document: ASTNode {
    
    // MARK: - Internal Properties
    
    let elements: [Element]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try elements.validate(with: storage)
    }
}
