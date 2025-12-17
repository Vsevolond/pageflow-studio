//
//  AlignmentType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct AlignmentType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case center, leading, trailing, top, bottom,
             topLeading, topTrailing, bottomLeading, bottomTrailing
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
