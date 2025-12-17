//
//  VerticalAlignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    vertical_alignment_type: $ => seq(
//        optional("VerticalAlignment"),
//        seq(".", $.vertical_alignment_value)
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
//        "center",
//        "top",
//        "bottom"
//    )
//
    func verticalAlignmentValue(
        from node: Node
    ) throws(ASTParseError) -> VerticalAlignmentType.Value {
        guard let text = node.text,
              let value = VerticalAlignmentType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
