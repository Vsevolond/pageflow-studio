//
//  Color-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    color_type: $ => seq(
//        optional("Color"),
//        seq(".", $.color_value)
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
//        "red", "green", "blue", "cyan", "magenta", "yellow",
//        "black", "gray", "white", "darkGray", "lightGray",
//        "brown", "lime", "olive", "orange", "pink", "purple",
//        "teal", "violet"
//    )
//
    func colorValue(
        from node: Node
    ) throws(ASTParseError) -> ColorType.Value {
        guard let text = node.text,
              let value = ColorType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
