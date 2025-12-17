//
//  Listing-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    listing_element: $ => seq(
//        "Listing",
//        "(",
//        $.file_name,
//        ")",
//        repeat($.listing_modifier)
//    )
//
    func listingElement(
        from node: Node
    ) throws(ASTParseError) -> ListingElement {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "file_name" else {
            throw .unknown(range: child.range)
        }
        
        let name = try fileName(from: child)
        
        var modifiers: [ListingElement.Modifier] = []
        
        for index in 1..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "listing_modifier" else {
                throw .unknown(range: child.range)
            }
            
            let modifier = try listingModifier(from: child)
            modifiers.append(modifier)
        }
        
        return ListingElement(
            name: name,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    listing_modifier: $ => seq(
//        ".",
//        choice(
//            $.code_modifiers,
//            $.font_modifiers,
//            $.figure_modifiers
//        )
//    )
//
    func listingModifier(
        from node: Node
    ) throws(ASTParseError) -> ListingElement.Modifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_modifiers":
            let modifier = try codeModifiers(from: child)
            return .code(modifier)
            
        case "font_modifiers":
            let modifier = try fontModifiers(from: child)
            return .font(modifier)
            
        case "figure_modifiers":
            let modifier = try figureModifiers(from: child)
            return .figure(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
