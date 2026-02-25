//
//  LayoutModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import Rearrange

extension ASTParserImpl {
    
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
//        token.immediate("padding"),
//        "(",
//        $.expression,
//        optional(
//            seq(
//              ",",
//              $.edge_type
//            )
//        ),
//        ")"
//    )
//
    func paddingModifier(
        from node: Node
    ) throws(ASTParseError) -> PaddingModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        let value = try expression(from: child)
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "edge_type" else {
                throw .unknown(range: child.range)
            }
            
            let edge = try edgeType(from: child)
            
            return PaddingModifier(
                value: value,
                edge: edge,
                range: node.range
            )
            
        } else {
            let edge = EdgeType(value: .all, range: .notFound)
            
            return PaddingModifier(
                value: value,
                edge: edge,
                range: node.range
            )
        }
    }
    
//    
//    offset_modifier: $ => seq(
//        token.immediate("offset"),
//        "(",
//        $.expression,
//        optional(
//            seq(
//              ",",
//              $.axis_type
//            )
//        ),
//        ")"
//    )
//
    func offsetModifier(
        from node: Node
    ) throws(ASTParseError) -> OffsetModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        let value = try expression(from: child)
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "axis_type" else {
                throw .unknown(range: child.range)
            }
            
            let axis = try axisType(from: child)
            
            return OffsetModifier(
                value: value,
                axis: axis,
                range: node.range
            )
            
        } else {
            let axis = AxisType(value: .horizontal, range: .notFound)
            
            return OffsetModifier(
                value: value,
                axis: axis,
                range: node.range
            )
        }
    }
}
