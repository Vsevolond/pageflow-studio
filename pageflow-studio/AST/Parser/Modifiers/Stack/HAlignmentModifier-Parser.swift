//
//  HAlignmentModifier-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    halignment_modifier: $ => seq(
//        "alignment",
//        "(",
//        $.vertical_alignment_type,
//        ")"
//    )
//
    func hAlignmentModifier(
        from node: Node
    ) throws(ASTParseError) -> HAlignmentModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "vertical_alignment_type":
            let value = try verticalAlignmentType(from: child)
            
            return HAlignmentModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
