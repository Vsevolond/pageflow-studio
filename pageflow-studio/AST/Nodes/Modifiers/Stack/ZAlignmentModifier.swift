//
//  ZAlignmentModifier.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import SwiftUI

struct ZAlignmentModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: AlignmentType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension ZAlignmentModifier {
    
    var rawValue: Alignment {
        value.rawValue
    }
}
