//
//  CodeLanguage-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//    
//    code_language_type: $ => seq(
//        optional("CodeLanguage"),
//        seq(".", $.code_language_value)
//    )
//
    func codeLanguageType(
        from node: Node
    ) throws(ASTParseError) -> CodeLanguageType {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "code_language_value":
            let value = try codeLanguageValue(from: child)
            
            return CodeLanguageType(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    code_language_value: $ => choice(
//        "cucumber", "abap", "ada", "ahk", "antlr", "apacheconf",
//        "applescript", "as", "aspectj", "autoit", "asy", "awk",
//        "basemake", "bash", "bat", "bbcode", "befunge", "bmax", "boo",
//        "brainfuck", "bro", "bugs", "c", "ceylon", "cfm", "cfs", "cheetah",
//        "clj", "cmake", "cobol", "cl", "console", "control", "coq", "cpp",
//        "croc", "csharp", "css", "cuda", "cyx", "d", "dg", "diff", "django",
//        "dpatch", "duel", "dylan", "ec", "erb", "evoque", "fan", "fancy",
//        "fortran", "gas", "genshi", "glsl", "gnuplot", "go", "gosu",
//        "groovy", "gst", "haml", "haskell", "hxml", "html", "http", "hx",
//        "idl", "irc", "ini", "java", "jade", "js", "json", "jsp", "kconfig",
//        "koka", "lasso", "livescrit", "llvm", "logos", "lua", "mako",
//        "mason", "matlab", "minid", "monkey", "moon", "mxml", "myghty",
//        "mysql", "nasm", "newlisp", "newspeak", "numpy", "ocaml",
//        "octave", "ooc", "perl", "php", "plpgsql", "postgresql",
//        "postscript", "pot", "prolog", "psql", "puppet", "python",
//        "qml", "ragel", "raw", "ruby", "rhtml", "sass", "scheme",
//        "smalltalk", "sql", "ssp", "tcl", "tea", "tex", "text",
//        "vala", "vgl", "xml", "xquery", "yaml"
//    )
//
    func codeLanguageValue(
        from node: Node
    ) throws(ASTParseError) -> CodeLanguageType.Value {
        guard let text = node.text,
              let value = CodeLanguageType.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
