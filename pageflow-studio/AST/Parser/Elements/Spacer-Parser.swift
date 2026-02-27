//
//  Spacer-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import CodeEditTextView

extension ASTParserImpl {
    
//
//    spacer_element: $ => seq(
//        "Spacer",
//        "(",
//        $.expression,
//        ")"
//    )
//
    func spacerElement(
        from node: Node
    ) throws(ASTParseError) -> SpacerElement {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        if child.range.isEmpty {
            return SpacerElement(range: node.range)
            
        } else {
            let expression = try expression(from: child)
            
            return SpacerElement(
                value: expression,
                range: child.range
            )
        }
    }
}
