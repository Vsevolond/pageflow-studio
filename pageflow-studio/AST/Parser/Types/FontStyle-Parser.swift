//
//  FontStyle-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    font_style_type: $ => seq(
//        optional("FontStyle"),
//        seq(".", $.font_style_value)
//    )
//
    func fontStyleType(
        from node: Node
    ) throws(ASTParseError) -> FontStyleType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "font_style_value":
            let value = try fontStyleValue(from: child)
            
            return FontStyleType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    font_style_value: $ => choice(
//        "medium",
//        "bold",
//        "italic",
//        "monospaced",
//        "smallCaps"
//    )
//
    func fontStyleValue(
        from node: Node
    ) throws(ASTParseError) -> FontStyleType.Value {
        guard let text = node.text,
              let value = FontStyleType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
