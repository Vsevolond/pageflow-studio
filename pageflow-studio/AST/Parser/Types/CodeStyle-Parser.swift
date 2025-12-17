//
//  CodeStyle-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    code_style_type: $ => seq(
//        optional("CodeStyle"),
//        seq(".", $.code_style_value)
//    )
//
    func codeStyleType(
        from node: Node
    ) throws(ASTParseError) -> CodeStyleType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_style_value":
            let value = try codeStyleValue(from: child)
            
            return CodeStyleType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_style_value: $ => choice(
//        "manni", "fruity", "rrt", "autumn", "perldoc", "bw", "borland",
//        "emacs", "colorful", "vim", "murphy", "pastie", "vs", "friendly",
//        "trac", "native", "tango", "monokai"
//    )
//
    func codeStyleValue(
        from node: Node
    ) throws(ASTParseError) -> CodeStyleType.Value {
        guard let text = node.text,
              let value = CodeStyleType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
