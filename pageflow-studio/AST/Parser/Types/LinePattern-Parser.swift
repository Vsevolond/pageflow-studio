//
//  LinePattern-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    line_pattern_type: $ => choice(
//        seq(".", $.line_pattern_value),
//        $.invalid_type
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
//        token.immediate("dash"),
//        token.immediate("dashDot"),
//        token.immediate("dashDotDot"),
//        token.immediate("dot"),
//        token.immediate("solid"),
//        $.invalid_value
//    )
//
    func linePatternValue(from node: Node) throws(ASTParseError) -> LinePatternType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = LinePatternType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
