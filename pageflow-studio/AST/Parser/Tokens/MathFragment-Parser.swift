//
//  MathFragment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    math_element: $ => choice(
//        $.math_text,
//        $.newline
//    )
//    math_inline_element: $ => choice(
//        $.math_inline_text,
//        $.newline
//    )
//
    func mathElement(
        from node: Node
    ) throws(ASTParseError) -> MathFragment {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "math_text", "math_inline_text":
            let text = try text(from: child)
            
            return MathFragment(
                value: .mathText(text),
                range: child.range
            )
            
        case "newline":
            return MathFragment(
                value: .newline,
                range: child.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
