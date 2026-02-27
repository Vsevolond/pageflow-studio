//
//  Identifier.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import Foundation

struct Identifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: String
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
