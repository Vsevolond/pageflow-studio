//
//  Color-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    color_type: $ => choice(
//        seq(".", $.color_value),
//        $.invalid_type
//    )
//
    func colorType(
        from node: Node
    ) throws(ASTParseError) -> ColorType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "color_value":
            let value = try colorValue(from: child)
            
            return ColorType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    color_value: $ => choice(
//        token.immediate("red"),
//        token.immediate("green"),
//        token.immediate("blue"),
//        token.immediate("cyan"),
//        token.immediate("magenta"),
//        token.immediate("yellow"),
//        token.immediate("black"),
//        token.immediate("gray"),
//        token.immediate("white"),
//        token.immediate("darkGray"),
//        token.immediate("lightGray"),
//        token.immediate("brown"),
//        token.immediate("lime"),
//        token.immediate("olive"),
//        token.immediate("orange"),
//        token.immediate("pink"),
//        token.immediate("purple"),
//        token.immediate("teal"),
//        token.immediate("violet"),
//        $.invalid_value
//    )
//
    func colorValue(from node: Node) throws(ASTParseError) -> ColorType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = ColorType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
