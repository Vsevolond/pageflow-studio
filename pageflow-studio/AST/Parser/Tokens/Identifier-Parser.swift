//
//  Identifier-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {

//
//    identifier: $ => /[a-zA-Z_\-]*/
//
    func identifier(from node: Node) throws(ASTParseError) -> Identifier {
        guard let value = controller.textView.substring(from: node.range) else {
            throw .unknown(range: node.range)
        }
        
        return Identifier(
            value: value,
            range: node.range
        )
    }
}
