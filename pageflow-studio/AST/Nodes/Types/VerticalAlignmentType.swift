//
//  VerticalAlignmentType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct VerticalAlignmentType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case center, top, bottom
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
