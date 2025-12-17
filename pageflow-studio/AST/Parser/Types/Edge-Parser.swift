//
//  Edge-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    edge_type: $ => seq(
//        optional("Edge"),
//        seq(".", $.edge_value)
//    )
//
    func edgeType(
        from node: Node
    ) throws(ASTParseError) -> EdgeType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "edge_value":
            let value = try edgeValue(from: child)
            
            return EdgeType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    edge_value: $ => choice(
//        "top",
//        "bottom",
//        "leading",
//        "trailing",
//        "all"
//    )
//
    func edgeValue(
        from node: Node
    ) throws(ASTParseError) -> EdgeType.Value {
        guard let text = node.text,
              let value = EdgeType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
