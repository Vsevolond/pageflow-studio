//
//  TextEditingModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum TextEditingModifiers: ASTNode {
    
    // MARK: - Cases
    
    case underline(UnderlineModifier)
    case strikethrough(StrikethroughModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .underline(let underlineModifier):
            underlineModifier.range
            
        case .strikethrough(let strikethroughModifier):
            strikethroughModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .underline(let underlineModifier):
            try underlineModifier.validate(with: storage)
            
        case .strikethrough(let strikethroughModifier):
            try strikethroughModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct UnderlineModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let line: LinePatternType
    let color: ColorType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try line.validate(with: storage)
        try color.validate(with: storage)
    }
}

struct StrikethroughModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let line: LinePatternType
    let color: ColorType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try line.validate(with: storage)
        try color.validate(with: storage)
    }
}
