//
//  Constant-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    constant: $ => choice(
//        seq(
//            "@",
//            choice("width", "height", $.invalid_constant)
//        ),
//        $.invalid_constant
//    )
//
    func constant(from node: Node) throws(ASTParseError) -> Constant {
        guard let string = controller.textView.substring(from: node.range),
              let value = Constant.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return Constant(
            value: value,
            range: node.range
        )
    }
}
