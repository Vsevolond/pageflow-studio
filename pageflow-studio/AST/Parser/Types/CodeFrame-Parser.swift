//
//  CodeFrame-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    code_frame_type: $ => choice(
//        seq(".", $.code_frame_value),
//        $.invalid_type
//    )
//
    func codeFrameType(
        from node: Node
    ) throws(ASTParseError) -> CodeFrameType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_frame_value":
            let value = try codeFrameValue(from: child)
            
            return CodeFrameType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_frame_value: $ => choice(
//        token.immediate("lefline"),
//        token.immediate("topline"),
//        token.immediate("bottomline"),
//        token.immediate("lines"),
//        token.immediate("single"),
//        $.invalid_value
//    )
//
    func codeFrameValue(from node: Node) throws(ASTParseError) -> CodeFrameType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = CodeFrameType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
