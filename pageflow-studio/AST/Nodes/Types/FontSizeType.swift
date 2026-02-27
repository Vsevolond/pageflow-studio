//
//  FontSizeType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct FontSizeType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case tiny, script, footnote, small, normal,
             large, larger, largest, huge, hugest
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension FontSizeType {
    
    var rawValue: CGFloat {
        switch value {
        case .tiny: return 6
        case .script: return 8
        case .footnote: return 10
        case .small: return 11
        case .normal: return 12
        case .large: return 14
        case .larger: return 17
        case .largest: return 20
        case .huge: return 25
        case .hugest: return 30
        }
    }
}
