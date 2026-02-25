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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .language(let codeLanguageModifier):
            try codeLanguageModifier.validate(with: storage)
            
        case .style(let codeStyleModifier):
            try codeStyleModifier.validate(with: storage)
            
        case .frame(let codeFrameModifier):
            try codeFrameModifier.validate(with: storage)
            
        case .numbers(let codeNumbersModifier):
            try codeNumbersModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct CodeLanguageModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeLanguageType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct CodeStyleModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeStyleType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct CodeFrameModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: CodeFrameType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct CodeNumbersModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
