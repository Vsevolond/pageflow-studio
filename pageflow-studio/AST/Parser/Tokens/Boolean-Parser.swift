//
//  Boolean-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    bool_type: $ => choice("true", "false", $.invalid_constant)
//
    func boolean(from node: Node) throws (ASTParseError) -> Bool {
        guard let string = controller.textView.substring(from: node.range) else {
            throw .unknown(range: node.range)
        }
        
        switch string {
        case "true":
            return true
            
        case "false":
            return false
            
        default:
            throw .unknown(range: node.range)
        }
    }
}
