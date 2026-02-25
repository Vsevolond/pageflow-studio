//
//  CodeModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    code_modifiers: $ => choice(
//        $.code_language_modifier,
//        $.code_style_modifier,
//        $.code_frame_modifier,
//        $.code_numbers_modifier
//    )
//
    func codeModifiers(
        from node: Node
    ) throws(ASTParseError) -> CodeModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_language_modifier":
            let modifier = try codeLanguageModifier(from: child)
            return .language(modifier)
            
        case "code_style_modifier":
            let modifier = try codeStyleModifier(from: child)
            return .style(modifier)
            
        case "code_frame_modifier":
            let modifier = try codeFrameModifier(from: child)
            return .frame(modifier)
            
        case "code_numbers_modifier":
            let modifier = try codeNumbersModifier(from: child)
            return .numbers(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_language_modifier: $ => seq(
//        token.immediate("language"),
//        "(",
//        $.code_language_type,
//        ")"
//    )
//    
    func codeLanguageModifier(
        from node: Node
    ) throws(ASTParseError) -> CodeLanguageModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_language_type":
            let value = try codeLanguageType(from: child)
            
            return CodeLanguageModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_style_modifier: $ => seq(
//        token.immediate("style"),
//        "(",
//        $.code_style_type,
//        ")"
//    )
//    
    func codeStyleModifier(
        from node: Node
    ) throws(ASTParseError) -> CodeStyleModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_style_type":
            let value = try codeStyleType(from: child)
            
            return CodeStyleModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_frame_modifier: $ => seq(
//        token.immediate("frame"),
//        "(",
//        $.code_frame_type,
//        ")"
//    )
//    
    func codeFrameModifier(
        from node: Node
    ) throws(ASTParseError) -> CodeFrameModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_frame_type":
            let value = try codeFrameType(from: child)
            
            return CodeFrameModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_numbers_modifier: $ => seq(
//        token.immediate("numbers"),
//        "(",
//        $.bool_type,
//        ")"
//    )
//    
    func codeNumbersModifier(
        from node: Node
    ) throws(ASTParseError) -> CodeNumbersModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "bool_type":
            let value = try boolean(from: child)
            
            return CodeNumbersModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
