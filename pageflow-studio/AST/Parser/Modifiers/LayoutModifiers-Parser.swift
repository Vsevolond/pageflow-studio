//
//  LayoutModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    layout_modifiers: $ => choice(
//        $.padding_modifier,
//        $.offset_modifier
//    )
//
    func layoutModifiers(
        from node: Node
    ) throws(ASTParseError) -> LayoutModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "padding_modifier":
            let modifier = try paddingModifier(from: child)
            return .padding(modifier)
            
        case "offset_modifier":
            let modifier = try offsetModifier(from: child)
            return .offset(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    padding_modifier: $ => seq(
//        "padding",
//        "(",
//        $.edge_type,
//        ",",
//        $.expression,
//        ")"
//    )
//    
    func paddingModifier(
        from node: Node
    ) throws(ASTParseError) -> PaddingModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "edge_type" else {
            throw .unknown(range: child.range)
        }
        
        let edge = try edgeType(from: child)
        
        guard let child = child.nextNamedSibling else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        let value = try expression(from: child)
        
        return PaddingModifier(
            edge: edge,
            value: value,
            range: node.range
        )
    }
    
//    
//    offset_modifier: $ => seq(
//        "offset",
//        "(",
//        $.axis_type,
//        ",",
//        $.expression,
//        ")"
//    )
//    
    func offsetModifier(
        from node: Node
    ) throws(ASTParseError) -> OffsetModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "axis_type" else {
            throw .unknown(range: child.range)
        }
        
        let axis = try axisType(from: child)
        
        guard let child = child.nextNamedSibling else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        let value = try expression(from: child)
        
        return OffsetModifier(
            axis: axis,
            value: value,
            range: node.range
        )
    }
}
