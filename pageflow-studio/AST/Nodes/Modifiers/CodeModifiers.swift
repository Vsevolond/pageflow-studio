//
//  CodeModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum CodeModifiers: ASTNode {
    
    // MARK: - Cases
    
    case language(CodeLanguageModifier)
    case style(CodeStyleModifier)
    case frame(CodeFrameModifier)
    case numbers(CodeNumbersModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .language(let codeLanguageModifier):
            codeLanguageModifier.range
            
        case .style(let codeStyleModifier):
            codeStyleModifier.range
            
        case .frame(let codeFrameModifier):
            codeFrameModifier.range
            
        case .numbers(let codeNumbersModifier):
            codeNumbersModifier.range
        }
    }
}

// MARK: - Modifiers

struct CodeLanguageModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeLanguageType
    let range: NSRange
}

struct CodeStyleModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeStyleType
    let range: NSRange
}

struct CodeFrameModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeFrameType
    let range: NSRange
}

struct CodeNumbersModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
}
