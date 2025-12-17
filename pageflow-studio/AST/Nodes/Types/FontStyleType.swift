//
//  FontStyleType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct FontStyleType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case medium, bold, italic, monospaced, smallCaps
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
