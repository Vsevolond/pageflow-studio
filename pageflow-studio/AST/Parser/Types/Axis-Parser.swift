//
//  Axis-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    axis_type: $ => choice(
//        seq(".", $.axis_value),
//        $.invalid_type
//    )
//
    func axisType(
        from node: Node
    ) throws(ASTParseError) -> AxisType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "axis_value":
            let value = try axisValue(from: child)
            
            return AxisType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    axis_value: $ => choice(
//        token.immediate("vertical"),
//        token.immediate("horizontal"),
//        $.invalid_value
//    )
//
    func axisValue(from node: Node) throws(ASTParseError) -> AxisType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = AxisType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
