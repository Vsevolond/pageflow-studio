//
//  ASTParser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 10.12.2025.
//

import Foundation
import SwiftTreeSitter
import Rearrange

// MARK: - AST Parse Error

enum ASTParseError: Error {
    case unknown(range: NSRange)
}

// MARK: - AST Parser Protocol

protocol ASTParser: AnyObject {
    
    // MARK: - Internal Methods
    
    func parse(_ tree: Tree) throws(ASTParseError) -> Document
}

// MARK: - AST Parser Implementation

final class ASTParserImpl: ASTParser {
    
    // MARK: - Internal Methods
    
    func parse(_ tree: Tree) throws(ASTParseError) -> Document {
        guard let root = tree.rootNode else {
            return .blank
        }
        
        return try document(from: root)
    }
}

// MARK: - Internal Extensions

extension Node {
    
    // MARK: - Internal Properties
    
    var firstNamedChild: Node? {
        namedChild(at: 0)
    }
}

// MARK: - Private Extensions

private extension Document {
    
    // MARK: - Type Properties
    
    static var blank: Document {
        Document(elements: [], range: .zero)
    }
}
