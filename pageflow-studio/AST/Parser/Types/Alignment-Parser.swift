//
//  Alignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    alignment_type: $ => seq(
//        optional("Alignment"),
//        seq(".", $.alignment_value)
//    )
//
    func alignmentType(
        from node: Node
    ) throws(ASTParseError) -> AlignmentType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "alignment_value":
            let value = try alignmentValue(from: child)
            
            return AlignmentType(
                value: value,
                range: child.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    alignment_value: $ => choice(
//        "center",
//        "leading",
//        "trailing",
//        "top",
//        "bottom",
//        "topLeading",
//        "topTrailing",
//        "bottomLeading",
//        "bottomTrailing"
//    )
//
    func alignmentValue(
        from node: Node
    ) throws(ASTParseError) -> AlignmentType.Value {
        guard let text = node.text,
              let value = AlignmentType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
