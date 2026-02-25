//
//  Edge-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    edge_type: $ => choice(
//        seq(".", $.edge_value),
//        $.invalid_type
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
//        token.immediate("top"),
//        token.immediate("bottom"),
//        token.immediate("leading"),
//        token.immediate("trailing"),
//        token.immediate("all"),
//        $.invalid_value
//    )
//
    func edgeValue(from node: Node) throws(ASTParseError) -> EdgeType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = EdgeType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
