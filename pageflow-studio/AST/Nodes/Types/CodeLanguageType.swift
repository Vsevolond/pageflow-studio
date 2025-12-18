//
//  CodeLanguageType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct CodeLanguageType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case cucumber, abap, ada, ahk, antlr, apacheconf,
             applescript, `as`, aspectj, autoit, asy, awk,
             basemake, bash, bat, bbcode, befunge, bmax, boo,
             brainfuck, bro, bugs, c, ceylon, cfm, cfs, cheetah,
             clj, cmake, cobol, cl, console, control, coq, cpp,
             croc, csharp, css, cuda, cyx, d, dg, diff, django,
             dpatch, duel, dylan, ec, erb, evoque, fan, fancy,
             fortran, gas, genshi, glsl, gnuplot, go, gosu,
             groovy, gst, haml, haskell, hxml, html, http, hx,
             idl, irc, ini, java, jade, js, json, jsp, kconfig,
             koka, lasso, livescrit, llvm, logos, lua, mako,
             mason, matlab, minid, monkey, moon, mxml, myghty,
             mysql, nasm, newlisp, newspeak, numpy, ocaml,
             octave, ooc, perl, php, plpgsql, postgresql,
             postscript, pot, prolog, psql, puppet, python,
             qml, ragel, raw, ruby, rhtml, sass, scheme,
             smalltalk, sql, ssp, tcl, tea, tex, text,
             vala, vgl, xml, xquery, yaml
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
