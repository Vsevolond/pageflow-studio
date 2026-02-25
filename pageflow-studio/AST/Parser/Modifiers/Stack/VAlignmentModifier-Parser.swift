//
//  VAlignmentModifier-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//    
//    valignment_modifier: $ => seq(
//        token.immediate("alignment"),
//        "(",
//        $.horizontal_alignment_type,
//        ")"
//    )
//    
    func vAlignmentModifier(
        from node: Node
    ) throws(ASTParseError) -> VAlignmentModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "horizontal_alignment_type":
            let value = try horizontalAlignmentType(from: child)
            
            return VAlignmentModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
