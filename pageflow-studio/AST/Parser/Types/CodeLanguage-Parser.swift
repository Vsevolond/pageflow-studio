//
//  CodeLanguage-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {
    
//    
//    code_language_type: $ => choice(
//        seq(".", $.code_language_value),
//        $.invalid_type
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
//        token.immediate("cucumber"),
//        token.immediate("abap"),
//        token.immediate("ada"),
//        token.immediate("ahk"),
//        token.immediate("antlr"),
//        token.immediate("apacheconf"),
//        token.immediate("applescript"),
//        token.immediate("as"),
//        token.immediate("aspectj"),
//        token.immediate("autoit"),
//        token.immediate("asy"),
//        token.immediate("awk"),
//        token.immediate("basemake"),
//        token.immediate("bash"),
//        token.immediate("bat"),
//        token.immediate("bbcode"),
//        token.immediate("befunge"),
//        token.immediate("bmax"),
//        token.immediate("boo"),
//        token.immediate("brainfuck"),
//        token.immediate("bro"),
//        token.immediate("bugs"),
//        token.immediate("c"),
//        token.immediate("ceylon"),
//        token.immediate("cfm"),
//        token.immediate("cfs"),
//        token.immediate("cheetah"),
//        token.immediate("clj"),
//        token.immediate("cmake"),
//        token.immediate("cobol"),
//        token.immediate("cl"),
//        token.immediate("console"),
//        token.immediate("control"),
//        token.immediate("coq"),
//        token.immediate("cpp"),
//        token.immediate("croc"),
//        token.immediate("csharp"),
//        token.immediate("css"),
//        token.immediate("cuda"),
//        token.immediate("cyx"),
//        token.immediate("d"),
//        token.immediate("dg"),
//        token.immediate("diff"),
//        token.immediate("django"),
//        token.immediate("dpatch"),
//        token.immediate("duel"),
//        token.immediate("dylan"),
//        token.immediate("ec"),
//        token.immediate("erb"),
//        token.immediate("evoque"),
//        token.immediate("fan"),
//        token.immediate("fancy"),
//        token.immediate("fortran"),
//        token.immediate("gas"),
//        token.immediate("genshi"),
//        token.immediate("glsl"),
//        token.immediate("gnuplot"),
//        token.immediate("go"),
//        token.immediate("gosu"),
//        token.immediate("groovy"),
//        token.immediate("gst"),
//        token.immediate("haml"),
//        token.immediate("haskell"),
//        token.immediate("hxml"),
//        token.immediate("html"),
//        token.immediate("http"),
//        token.immediate("hx"),
//        token.immediate("idl"),
//        token.immediate("irc"),
//        token.immediate("ini"),
//        token.immediate("java"),
//        token.immediate("jade"),
//        token.immediate("js"),
//        token.immediate("json"),
//        token.immediate("jsp"),
//        token.immediate("kconfig"),
//        token.immediate("koka"),
//        token.immediate("lasso"),
//        token.immediate("livescrit"),
//        token.immediate("llvm"),
//        token.immediate("logos"),
//        token.immediate("lua"),
//        token.immediate("mako"),
//        token.immediate("mason"),
//        token.immediate("matlab"),
//        token.immediate("minid"),
//        token.immediate("monkey"),
//        token.immediate("moon"),
//        token.immediate("mxml"),
//        token.immediate("myghty"),
//        token.immediate("mysql"),
//        token.immediate("nasm"),
//        token.immediate("newlisp"),
//        token.immediate("newspeak"),
//        token.immediate("numpy"),
//        token.immediate("ocaml"),
//        token.immediate("octave"),
//        token.immediate("ooc"),
//        token.immediate("perl"),
//        token.immediate("php"),
//        token.immediate("plpgsql"),
//        token.immediate("postgresql"),
//        token.immediate("postscript"),
//        token.immediate("pot"),
//        token.immediate("prolog"),
//        token.immediate("psql"),
//        token.immediate("puppet"),
//        token.immediate("python"),
//        token.immediate("qml"),
//        token.immediate("ragel"),
//        token.immediate("raw"),
//        token.immediate("ruby"),
//        token.immediate("rhtml"),
//        token.immediate("sass"),
//        token.immediate("scheme"),
//        token.immediate("smalltalk"),
//        token.immediate("sql"),
//        token.immediate("ssp"),
//        token.immediate("tcl"),
//        token.immediate("tea"),
//        token.immediate("tex"),
//        token.immediate("text"),
//        token.immediate("vala"),
//        token.immediate("vgl"),
//        token.immediate("xml"),
//        token.immediate("xquery"),
//        token.immediate("yaml"),
//        $.invalid_value
//    )
//
    func codeLanguageValue(from node: Node) throws(ASTParseError) -> CodeLanguageType.Value {
        guard let string = controller.textView.substring(from: node.range),
              let value = CodeLanguageType.Value(rawValue: string)
        else {
            throw .unknown(range: node.range)
        }
        
        return value
    }
}
