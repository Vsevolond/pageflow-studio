//
//  HorizontalAlignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    horizontal_alignment_type: $ => choice(
//        seq(".", $.horizontal_alignment_value),
//        $.invalid_type
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
//        token.immediate("center"),
//        token.immediate("leading"),
//        token.immediate("trailing"),
//        $.invalid_value
//    )
//
    func horizontalAlignmentValue(from node: Node) throws(ASTParseError) -> HorizontalAlignmentType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = HorizontalAlignmentType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
