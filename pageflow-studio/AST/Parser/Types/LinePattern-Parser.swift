//
//  LinePattern-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    line_pattern_type: $ => seq(
//        optional("LinePattern"),
//        seq(".", $.line_pattern_value)
//    )
//
    func linePatternType(
        from node: Node
    ) throws(ASTParseError) -> LinePatternType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "line_pattern_value":
            let value = try linePatternValue(from: child)
            
            return LinePatternType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    line_pattern_value: $ => choice(
//        "dash",
//        "dashDot",
//        "dashDotDot",
//        "dot",
//        "solid"
//    )
//
    func linePatternValue(
        from node: Node
    ) throws(ASTParseError) -> LinePatternType.Value {
        guard let text = node.text,
              let value = LinePatternType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
