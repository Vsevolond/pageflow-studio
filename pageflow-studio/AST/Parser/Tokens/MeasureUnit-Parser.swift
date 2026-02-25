//
//  MeasureUnit-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//
//    measure_unit: $ => token.immediate(/pt|cm|mm|in/)
//
    func measureUnit(from node: Node) throws(ASTParseError) -> MeasureUnit {
        guard let string = controller.textView.substring(from: node.range),
              let value = MeasureUnit.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return MeasureUnit(
            value: value,
            range: node.range
        )
    }
}
