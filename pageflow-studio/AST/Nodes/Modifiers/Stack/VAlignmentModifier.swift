//
//  VAlignmentModifier.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import SwiftUI

struct VAlignmentModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: HorizontalAlignmentType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension VAlignmentModifier {
    
    var rawValue: HorizontalAlignment {
        value.rawValue
    }
}
