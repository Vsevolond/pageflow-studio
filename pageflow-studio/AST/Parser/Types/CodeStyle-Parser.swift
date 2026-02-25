//
//  CodeStyle-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    code_style_type: $ => choice(
//        seq(".", $.code_style_value),
//        $.invalid_type
//    )
//
    func codeStyleType(
        from node: Node
    ) throws(ASTParseError) -> CodeStyleType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_style_value":
            let value = try codeStyleValue(from: child)
            
            return CodeStyleType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_style_value: $ => choice(
//        token.immediate("manni"),
//        token.immediate("fruity"),
//        token.immediate("rrt"),
//        token.immediate("autumn"),
//        token.immediate("perldoc"),
//        token.immediate("bw"),
//        token.immediate("borland"),
//        token.immediate("emacs"),
//        token.immediate("colorful"),
//        token.immediate("vim"),
//        token.immediate("murphy"),
//        token.immediate("pastie"),
//        token.immediate("vs"),
//        token.immediate("friendly"),
//        token.immediate("trac"),
//        token.immediate("native"),
//        token.immediate("tango"),
//        token.immediate("monokai"),
//        $.invalid_value
//    )
//
    func codeStyleValue(from node: Node) throws(ASTParseError) -> CodeStyleType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = CodeStyleType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
