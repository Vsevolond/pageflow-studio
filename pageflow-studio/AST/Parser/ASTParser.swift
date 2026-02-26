//
//  ASTParser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 10.12.2025.
//

import Foundation
import Rearrange

import SwiftTreeSitter
import PageflowSourceEditor

// MARK: - AST Parse Error

enum ASTParseError: Error, Equatable {
    case unknown(range: NSRange)
}

// MARK: - AST Parser Protocol

protocol ASTParser: AnyObject {
    
    // MARK: - Internal Methods
    
    func parse(_ tree: Tree) throws(ASTParseError) -> Document
}

// MARK: - AST Parser Implementation

final class ASTParserImpl: ASTParser, Sendable {
    
    // MARK: - Internal Properties
    
    var controller: TextViewController
    
    // MARK: - Initializers
    
    init(controller: TextViewController) {
        self.controller = controller
    }
    
    // MARK: - Internal Methods
    
    func parse(_ tree: Tree) throws(ASTParseError) -> Document {
        guard let root = tree.rootNode else {
            return .blank
        }
        
        return try document(from: root)
    }
}

extension Document {
    
    // MARK: - Type Properties
    
    static var blank: Document {
        Document(elements: [], range: .zero)
    }
}
