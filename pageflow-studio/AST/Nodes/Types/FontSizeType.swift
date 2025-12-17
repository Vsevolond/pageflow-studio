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
}
