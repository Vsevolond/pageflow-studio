//
//  CodeFrame-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    code_frame_type: $ => seq(
//        optional("CodeFrame"),
//        seq(".", $.code_frame_value)
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
//        "lefline",
//        "topline",
//        "bottomline",
//        "lines",
//        "single"
//    )
//
    func codeFrameValue(
        from node: Node
    ) throws(ASTParseError) -> CodeFrameType.Value {
        guard let text = node.text,
              let value = CodeFrameType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
