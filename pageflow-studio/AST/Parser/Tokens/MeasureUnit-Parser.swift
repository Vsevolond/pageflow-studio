//
//  MeasureUnit-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    measure_unit: $ => token.immediate(/pt|cm|mm|in/)
//
    func measureUnit(
        from node: Node
    ) throws(ASTParseError) -> MeasureUnit {
        guard let text = node.text,
              let value = MeasureUnit.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return MeasureUnit(
            value: value,
            range: node.range
        )
    }
}
