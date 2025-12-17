//
//  HorizontalAlignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    horizontal_alignment_type: $ => seq(
//        optional("HorizontalAlignment"),
//        seq(".", $.horizontal_alignment_value)
//    )
//
    func horizontalAlignmentType(
        from node: Node
    ) throws(ASTParseError) -> HorizontalAlignmentType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "horizontal_alignment_value":
            let value = try horizontalAlignmentValue(from: child)
            
            return HorizontalAlignmentType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    horizontal_alignment_value: $ => choice(
//        "center",
//        "leading",
//        "trailing"
//    )
//
    func horizontalAlignmentValue(
        from node: Node
    ) throws(ASTParseError) -> HorizontalAlignmentType.Value {
        guard let text = node.text,
              let value = HorizontalAlignmentType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
