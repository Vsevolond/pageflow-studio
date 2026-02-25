//
//  Number-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
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
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "measure_unit" else {
                throw .unknown(range: child.range)
            }
            
            let unit = try measureUnit(from: child)
            
            return Number(
                value: value,
                unit: unit,
                range: node.range
            )
            
        } else {
            return Number(
                value: value,
                range: node.range
            )
        }
    }
    
//
//    number_type: $ => choice($.integer, $.decimal, $.invalid_number)
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
        guard let string = controller.textView.substring(from: node.range),
              let integer = Int(string)
        else {
            throw .unknown(range: node.range)
        }
        
        return integer
    }
    
//
//    decimal: $ => /([1-9][0-9]*|0)\.[0-9]+/
//
    func decimal(from node: Node) throws(ASTParseError) -> Double {
        guard let string = controller.textView.substring(from: node.range),
              let decimal = Double(string)
        else {
            throw .unknown(range: node.range)
        }
        
        return decimal
    }
}
