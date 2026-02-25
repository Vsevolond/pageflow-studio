//
//  FontSize-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    font_size_type: $ => choice(
//        seq(".", $.font_size_value),
//        $.invalid_type
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
//        token.immediate("tiny"),
//        token.immediate("script"),
//        token.immediate("footnote"),
//        token.immediate("small"),
//        token.immediate("normal"),
//        token.immediate("large"),
//        token.immediate("larger"),
//        token.immediate("largest"),
//        token.immediate("huge"),
//        token.immediate("hugest"),
//        $.invalid_value
//    )
//
    func fontSizeValue(from node: Node) throws(ASTParseError) -> FontSizeType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = FontSizeType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
