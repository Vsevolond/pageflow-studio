//
//  TextFragment.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct TextFragment: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value {
        case rawText(String)
        case inlineMath([MathFragment])
        case newline
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
