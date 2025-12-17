//
//  FontSize-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    font_size_type: $ => seq(
//        optional("FontSize"),
//        seq(".", $.font_size_value)
//    )
//
    func fontSizeType(
        from node: Node
    ) throws(ASTParseError) -> FontSizeType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "font_size_value":
            let value = try fontSizeValue(from: child)
            
            return FontSizeType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    font_size_value: $ => choice(
//        "tiny",
//        "script",
//        "footnote",
//        "small",
//        "normal",
//        "large",
//        "larger",
//        "largest",
//        "huge",
//        "hugest"
//    )
//
    func fontSizeValue(
        from node: Node
    ) throws(ASTParseError) -> FontSizeType.Value {
        guard let text = node.text,
              let value = FontSizeType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
