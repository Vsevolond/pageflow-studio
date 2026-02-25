//
//  TextFragment-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import Foundation
import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    text_fragment: $ => choice(
//        $.raw_text,
//        $.math_content,
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
        case "raw_text":
            let text = try text(from: child)
            
            return TextFragment(
                value: .rawText(text),
                range: child.range
            )
            
        case "math_content":
            let content = try mathContent(from: child)
            
            return TextFragment(
                value: .rawMath(content),
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
//    raw_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\"$]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//    math_text: $ => token(
//        repeat1(
//            choice(
//                /[^\\$]/,
//                seq("\\", /[^\\]/)
//            )
//        )
//    )
//
    func text(from node: Node) throws(ASTParseError) -> String {
        guard let text = controller.textView.substring(from: node.range) else {
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
