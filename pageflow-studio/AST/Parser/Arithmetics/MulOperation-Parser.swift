//
//  MulOperation-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    mul_operation: $ => choice("*", "/")
//
    func mulOperation(
        from node: Node
    ) throws(ASTParseError) -> MulOperation {
        guard let string = controller.textView.substring(from: node.range),
              let value = MulOperation.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return MulOperation(
            value: value,
            range: node.range
        )
    }
}
