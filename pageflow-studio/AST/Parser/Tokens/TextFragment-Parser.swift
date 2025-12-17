//
//  TextFragment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import Foundation
import SwiftTreeSitter

extension ASTParser {
    
//
//    text_fragment: $ => choice(
//        $.raw_text,
//        $.math_inline_fragment,
//        $.newline
//    )
//    text_arg_fragment: $ => choice(
//        $.raw_arg_text,
//        $.math_inline_fragment,
//        $.newline
//    )
//
    func textFragment(
        from node: Node
    ) throws(ASTParseError) -> TextFragment {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "raw_text", "raw_arg_text":
            let text = try text(from: child)
            
            return TextFragment(
                value: .rawText(text),
                range: child.range
            )
            
        case "math_inline_fragment":
            let fragments = try mathInlineFragment(from: child)
            
            return TextFragment(
                value: .inlineMath(fragments),
                range: child.range
            )
            
        case "newline":
            return TextFragment(
                value: .newline,
                range: child.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//
//    math_inline_fragment: $ => seq(
//        $.math_separator,
//        repeat($.math_inline_element),
//        $.math_separator
//    )
//
    func mathInlineFragment(
        from node: Node
    ) throws(ASTParseError) -> [MathFragment] {
        var fragments: [MathFragment] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "math_inline_element":
                let fragment = try mathElement(from: child)
                fragments.append(fragment)
                
            case "math_separator":
                continue
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return fragments
    }
    
//
//    raw_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\{}$]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//    raw_arg_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\()$]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//    math_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\{}]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//    math_inline_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\$]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//
    func text(
        from node: Node
    ) throws(ASTParseError) -> String {
        guard let text = node.text else {
            throw .unknown(range: node.range)
        }
        
        let formatted = text.replacingOccurrences(of: "\n", with: " ")
        
        if formatted.allSatisfy({ $0.isWhitespace }) {
            return ""
            
        } else {
            return formatted
        }
    }
}
