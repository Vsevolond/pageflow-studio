//
//  AddOperation-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    add_operation: $ => choice("+", "-")
//
    func addOperation(
        from node: Node
    ) throws(ASTParseError) -> AddOperation {
        guard let string = controller.textView.substring(from: node.range),
              let value = AddOperation.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return AddOperation(
            value: value,
            range: node.range
        )
    }
}
