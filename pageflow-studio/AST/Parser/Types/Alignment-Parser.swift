//
//  Alignment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    alignment_type: $ => choice(
//        seq(".", $.alignment_value),
//        $.invalid_type
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
//        token.immediate("center"),
//        token.immediate("leading"),
//        token.immediate("trailing"),
//        token.immediate("top"),
//        token.immediate("bottom"),
//        token.immediate("topLeading"),
//        token.immediate("topTrailing"),
//        token.immediate("bottomLeading"),
//        token.immediate("bottomTrailing"),
//        $.invalid_value
//    )
//
    func alignmentValue(from node: Node) throws(ASTParseError) -> AlignmentType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = AlignmentType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
