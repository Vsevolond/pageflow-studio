//
//  SpacerElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct SpacerElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression?
    let range: NSRange
    
    // MARK: - Internal Properties
    
    init(
        value: Expression? = nil,
        range: NSRange
    ) {
        self.value = value
        self.range = range
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        guard let value else { return }
        
        try value.validate(with: storage)
    }
}
