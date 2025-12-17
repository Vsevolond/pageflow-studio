//
//  Boolean-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    bool_type: $ => choice("true", "false")
//
    func boolean(
        from node: Node
    ) throws (ASTParseError) -> Bool {
        switch node.text {
        case "true":
            return true
            
        case "false":
            return false
            
        default:
            throw .unknown(range: node.range)
        }
    }
}
