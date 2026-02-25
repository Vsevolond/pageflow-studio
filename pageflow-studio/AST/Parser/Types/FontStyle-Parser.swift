//
//  FontStyle-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    font_style_type: $ => choice(
//        seq(".", $.font_style_value),
//        $.invalid_type
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
//        token.immediate("medium"),
//        token.immediate("bold"),
//        token.immediate("italic"),
//        token.immediate("monospaced"),
//        token.immediate("smallCaps"),
//        $.invalid_value
//    )
//
    func fontStyleValue(from node: Node) throws(ASTParseError) -> FontStyleType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = FontStyleType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
