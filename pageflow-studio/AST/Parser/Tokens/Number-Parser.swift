//
//  Number-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    number: $ => seq(
//        $.number_type,
//        optional($.measure_unit)
//    )
//
    func number(
        from node: Node
    ) throws(ASTParseError) -> Number {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "number_type" else {
            throw .unknown(range: child.range)
        }
        
        let value = try numberType(from: child)
        
        guard let child = child.nextNamedSibling else {
            return Number(
                value: value,
                range: node.range
            )
        }
        
        guard child.nodeType == "measure_unit" else {
            throw .unknown(range: child.range)
        }
        
        let unit = try measureUnit(from: child)
        
        return Number(
            value: value,
            unit: unit,
            range: node.range
        )
    }
    
//
//    number_type: $ => choice($.integer, $.decimal)
//
    func numberType(
        from node: Node
    ) throws(ASTParseError) -> Number.Value {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "integer":
            let value = try integer(from: child)
            return .integer(value)
            
        case "decimal":
            let value = try decimal(from: child)
            return .decimal(value)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//
//    integer: $ => /[1-9][0-9]*/
//
    func integer(from node: Node) throws(ASTParseError) -> Int {
        guard let text = node.text,
              let integer = Int(text)
        else {
            throw .unknown(range: node.range)
        }
        
        return integer
    }
    
//
//    decimal: $ => /[0-9]+\.[0-9]+/
//
    func decimal(from node: Node) throws(ASTParseError) -> Double {
        guard let text = node.text,
              let decimal = Double(text)
        else {
            throw .unknown(range: node.range)
        }
        
        return decimal
    }
}
