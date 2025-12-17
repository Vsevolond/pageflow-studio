//
//  ZAlignmentModifier-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    zalignment_modifier: $ => seq(
//        "alignment",
//        "(",
//        $.alignment_type,
//        ")"
//    )
//    
    func zAlignmentModifier(
        from node: Node
    ) throws(ASTParseError) -> ZAlignmentModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "alignment_type":
            let value = try alignmentType(from: child)
            
            return ZAlignmentModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
