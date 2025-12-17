//
//  Axis-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    axis_type: $ => seq(
//        optional("Axis"),
//        seq(".", $.axis_value)
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
//        "vertical",
//        "horizontal"
//    )
//
    func axisValue(
        from node: Node
    ) throws(ASTParseError) -> AxisType.Value {
        guard let text = node.text,
              let value = AxisType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
