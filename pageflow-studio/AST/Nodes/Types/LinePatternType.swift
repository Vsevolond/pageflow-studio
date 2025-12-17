//
//  LinePatternType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct LinePatternType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case dash, dashDot, dashDotDot, dot, solid
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
