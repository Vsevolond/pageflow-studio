//
//  MathContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 25.02.2026.
//

import Foundation

struct MathContent: ASTNode {
    
    // MARK: - Internal Properties
    
    let fragments: [MathFragment]
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try fragments.validate(with: storage)
    }
}
