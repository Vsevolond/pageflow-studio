//
//  VerticalAlignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    vertical_alignment_type: $ => choice(
//        seq(".", $.vertical_alignment_value),
//        $.invalid_type
//    )
//
    func verticalAlignmentType(
        from node: Node
    ) throws(ASTParseError) -> VerticalAlignmentType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "vertical_alignment_value":
            let value = try verticalAlignmentValue(from: child)
            
            return VerticalAlignmentType(
                value: value,
                range: child.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    vertical_alignment_value: $ => choice(
//        token.immediate("center"),
//        token.immediate("top"),
//        token.immediate("bottom"),
//        $.invalid_value
//    )
//
    func verticalAlignmentValue(from node: Node) throws(ASTParseError) -> VerticalAlignmentType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = VerticalAlignmentType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
