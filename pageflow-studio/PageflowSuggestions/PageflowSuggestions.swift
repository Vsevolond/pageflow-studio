//
//  PageflowSuggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import Foundation
import Rearrange
import SwiftUI

@MainActor
enum PageflowSuggestions {}

// MARK: - Extensions

extension PageflowSuggestions {
    
    // MARK: - Suggestions for context
    
    static func suggestions(
        for context: PageflowSuggestionContext,
        provider: FileSuggestionsProvider?
    ) -> [PageflowSuggestionEntry]? {
        switch context {
        case .content(let block):
            return contentSuggestions(for: block)
            
        case .modifier(let element):
            return modifierSuggestions(for: element)
            
        case .value(let type):
            return valueSuggestions(for: type)
            
        case .text:
            return nil
            
        case .file(let type):
            return fileSuggestions(for: type, provider: provider)
            
        case .math:
            return mathSuggestions
            
        case .boolean:
            return booleanSuggestions
            
        case .constant:
            return constantSuggestions
        }
    }
    
    // MARK: - Content Suggestions
    
    private static func contentSuggestions(
        for block: PageflowSuggestionContext.Blocks
    ) -> [PageflowSuggestionEntry] {
        switch block {
        case .root: [
            PageflowSuggestions.Blocks.newPage,
            PageflowSuggestions.Blocks.section,
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
            
        case .newPage: [
            PageflowSuggestions.Blocks.section,
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
            
        case .sectionNewPage: [
            PageflowSuggestions.Blocks.subSection,
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
            
        case .section: [
            PageflowSuggestions.Blocks.newPage,
            PageflowSuggestions.Blocks.subSection,
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
            
        case .subSection: [
            PageflowSuggestions.Blocks.newPage,
            PageflowSuggestions.Blocks.subSection,
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
            
        case .vStack, .hStack, .zStack: [
            PageflowSuggestions.Blocks.vStack,
            PageflowSuggestions.Blocks.hStack,
            PageflowSuggestions.Blocks.zStack,
            PageflowSuggestions.Blocks.text,
            PageflowSuggestions.Blocks.math,
            PageflowSuggestions.Blocks.image,
            PageflowSuggestions.Blocks.listing,
            PageflowSuggestions.Blocks.spacer,
            PageflowSuggestions.Blocks.divider
        ]
        }
    }
    
    // MARK: - Modifier Suggestions
    
    private static func modifierSuggestions(
        for element: PageflowSuggestionContext.Elements
    ) -> [PageflowSuggestionEntry] {
        switch element {
        case .newPage: [
            /// page modifiers
            PageflowSuggestions.Modifiers.header,
            PageflowSuggestions.Modifiers.footer,
            /// inset modifiers
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.marginTop,
            PageflowSuggestions.Modifiers.marginBottom,
            PageflowSuggestions.Modifiers.marginLeading,
            PageflowSuggestions.Modifiers.marginTrailing
        ]
            
        case .vStack: [
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// inset modifiers
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.marginTop,
            PageflowSuggestions.Modifiers.marginBottom,
            PageflowSuggestions.Modifiers.marginLeading,
            PageflowSuggestions.Modifiers.marginTrailing,
            /// figure modifiers
            PageflowSuggestions.Modifiers.enumerated,
            PageflowSuggestions.Modifiers.caption,
            /// subfigure modifiers
            PageflowSuggestions.Modifiers.subfigure,
            /// container modifiers
            PageflowSuggestions.Modifiers.spacing,
            /// background modifiers
            PageflowSuggestions.Modifiers.background,
            /// valignment modifier
            PageflowSuggestions.Modifiers.vAlignment
        ]
            
        case .hStack: [
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// inset modifiers
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.marginTop,
            PageflowSuggestions.Modifiers.marginBottom,
            PageflowSuggestions.Modifiers.marginLeading,
            PageflowSuggestions.Modifiers.marginTrailing,
            /// figure modifiers
            PageflowSuggestions.Modifiers.enumerated,
            PageflowSuggestions.Modifiers.caption,
            /// subfigure modifiers
            PageflowSuggestions.Modifiers.subfigure,
            /// container modifiers
            PageflowSuggestions.Modifiers.spacing,
            /// background modifiers
            PageflowSuggestions.Modifiers.background,
            /// halignment modifier
            PageflowSuggestions.Modifiers.hAlignment
        ]
            
        case .zStack: [
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// inset modifiers
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.marginTop,
            PageflowSuggestions.Modifiers.marginBottom,
            PageflowSuggestions.Modifiers.marginLeading,
            PageflowSuggestions.Modifiers.marginTrailing,
            /// figure modifiers
            PageflowSuggestions.Modifiers.enumerated,
            PageflowSuggestions.Modifiers.caption,
            /// subfigure modifiers
            PageflowSuggestions.Modifiers.subfigure,
            /// container modifiers
            PageflowSuggestions.Modifiers.spacing,
            /// background modifiers
            PageflowSuggestions.Modifiers.background,
            /// zalignment modifier
            PageflowSuggestions.Modifiers.zAlignment
        ]
            
        case .text: [
            /// text layout modifiers
            PageflowSuggestions.Modifiers.textAlignment,
            PageflowSuggestions.Modifiers.lineSpacing,
            /// text editing modifiers
            PageflowSuggestions.Modifiers.underline,
            PageflowSuggestions.Modifiers.underlineDash,
            PageflowSuggestions.Modifiers.underlineDashDot,
            PageflowSuggestions.Modifiers.underlineDashDotDot,
            PageflowSuggestions.Modifiers.underlineSolid,
            PageflowSuggestions.Modifiers.strikethrough,
            PageflowSuggestions.Modifiers.strikethroughDash,
            PageflowSuggestions.Modifiers.strikethroughDashDot,
            PageflowSuggestions.Modifiers.strikethroughDashDotDot,
            PageflowSuggestions.Modifiers.strikethroughSolid,
            /// font modifiers
            PageflowSuggestions.Modifiers.fontSize,
            PageflowSuggestions.Modifiers.fontStyle,
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// foreground modifiers
            PageflowSuggestions.Modifiers.tint,
            /// background modifiers
            PageflowSuggestions.Modifiers.background
        ]
            
        case .math: [
            /// text layout modifiers
            PageflowSuggestions.Modifiers.textAlignment,
            PageflowSuggestions.Modifiers.lineSpacing,
            /// font modifiers
            PageflowSuggestions.Modifiers.fontSize,
            PageflowSuggestions.Modifiers.fontStyle,
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// inset modifiers
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.margin,
            PageflowSuggestions.Modifiers.marginTop,
            PageflowSuggestions.Modifiers.marginBottom,
            PageflowSuggestions.Modifiers.marginLeading,
            PageflowSuggestions.Modifiers.marginTrailing,
            /// foreground modifiers
            PageflowSuggestions.Modifiers.tint,
            /// background modifiers
            PageflowSuggestions.Modifiers.background
        ]
            
        case .divider: [
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// foreground modifiers
            PageflowSuggestions.Modifiers.tint
        ]
            
        case .image: [
            /// frame modifiers
            PageflowSuggestions.Modifiers.width,
            PageflowSuggestions.Modifiers.height,
            /// alignment modifiers
            PageflowSuggestions.Modifiers.layout,
            /// layout modifiers
            PageflowSuggestions.Modifiers.padding,
            PageflowSuggestions.Modifiers.paddingTop,
            PageflowSuggestions.Modifiers.paddingBottom,
            PageflowSuggestions.Modifiers.paddingLeading,
            PageflowSuggestions.Modifiers.paddingTrailing,
            PageflowSuggestions.Modifiers.offset,
            PageflowSuggestions.Modifiers.offsetVertical,
            /// figure modifiers
            PageflowSuggestions.Modifiers.enumerated,
            PageflowSuggestions.Modifiers.caption,
            /// subfigure modifiers
            PageflowSuggestions.Modifiers.subfigure
        ]
            
        case .listing: [
            /// code modifiers
            PageflowSuggestions.Modifiers.codeLanguage,
            PageflowSuggestions.Modifiers.codeStyle,
            PageflowSuggestions.Modifiers.codeFrame,
            PageflowSuggestions.Modifiers.codeNumbers,
            /// font modifiers
            PageflowSuggestions.Modifiers.fontSize,
            PageflowSuggestions.Modifiers.fontStyle,
            /// figure modifiers
            PageflowSuggestions.Modifiers.enumerated,
            PageflowSuggestions.Modifiers.caption
        ]
        }
    }
    
    // MARK: - Value Suggestions
    
    private static func valueSuggestions(
        for type: PageflowSuggestionContext.Types
    ) -> [PageflowSuggestionEntry] {
        switch type {
        case .horizontalAlignment: [
            PageflowSuggestions.Values.HorizontalAlignment.center,
            PageflowSuggestions.Values.HorizontalAlignment.leading,
            PageflowSuggestions.Values.HorizontalAlignment.trailing
        ]
            
        case .verticalAlignment: [
            PageflowSuggestions.Values.VerticalAlignment.center,
            PageflowSuggestions.Values.VerticalAlignment.top,
            PageflowSuggestions.Values.VerticalAlignment.bottom
        ]
            
        case .alignment: [
            PageflowSuggestions.Values.Alignment.center,
            PageflowSuggestions.Values.Alignment.leading,
            PageflowSuggestions.Values.Alignment.trailing,
            PageflowSuggestions.Values.Alignment.top,
            PageflowSuggestions.Values.Alignment.bottom,
            PageflowSuggestions.Values.Alignment.topLeading,
            PageflowSuggestions.Values.Alignment.topTrailing,
            PageflowSuggestions.Values.Alignment.bottomLeading,
            PageflowSuggestions.Values.Alignment.bottomTrailing
        ]
            
        case .edge: [
            PageflowSuggestions.Values.Edge.leading,
            PageflowSuggestions.Values.Edge.trailing,
            PageflowSuggestions.Values.Edge.top,
            PageflowSuggestions.Values.Edge.bottom,
            PageflowSuggestions.Values.Edge.all
        ]
            
        case .axis: [
            PageflowSuggestions.Values.Axis.vertical,
            PageflowSuggestions.Values.Axis.horizontal
        ]
            
        case .color: [
            PageflowSuggestions.Values.Color.red,
            PageflowSuggestions.Values.Color.green,
            PageflowSuggestions.Values.Color.blue,
            PageflowSuggestions.Values.Color.cyan,
            PageflowSuggestions.Values.Color.magenta,
            PageflowSuggestions.Values.Color.yellow,
            PageflowSuggestions.Values.Color.black,
            PageflowSuggestions.Values.Color.gray,
            PageflowSuggestions.Values.Color.white,
            PageflowSuggestions.Values.Color.darkGray,
            PageflowSuggestions.Values.Color.lightGray,
            PageflowSuggestions.Values.Color.brown,
            PageflowSuggestions.Values.Color.lime,
            PageflowSuggestions.Values.Color.olive,
            PageflowSuggestions.Values.Color.orange,
            PageflowSuggestions.Values.Color.pink,
            PageflowSuggestions.Values.Color.purple,
            PageflowSuggestions.Values.Color.teal,
            PageflowSuggestions.Values.Color.violet
        ]
            
        case .linePattern: [
            PageflowSuggestions.Values.LinePattern.dash,
            PageflowSuggestions.Values.LinePattern.dashDot,
            PageflowSuggestions.Values.LinePattern.dashDotDot,
            PageflowSuggestions.Values.LinePattern.dot,
            PageflowSuggestions.Values.LinePattern.solid
        ]
            
        case .fontSize: [
            PageflowSuggestions.Values.FontSize.tiny,
            PageflowSuggestions.Values.FontSize.script,
            PageflowSuggestions.Values.FontSize.footnote,
            PageflowSuggestions.Values.FontSize.small,
            PageflowSuggestions.Values.FontSize.normal,
            PageflowSuggestions.Values.FontSize.large,
            PageflowSuggestions.Values.FontSize.larger,
            PageflowSuggestions.Values.FontSize.largest,
            PageflowSuggestions.Values.FontSize.huge,
            PageflowSuggestions.Values.FontSize.hugest
        ]
            
        case .fontStyle: [
            PageflowSuggestions.Values.FontStyle.medium,
            PageflowSuggestions.Values.FontStyle.bold,
            PageflowSuggestions.Values.FontStyle.italic,
            PageflowSuggestions.Values.FontStyle.monospaced,
            PageflowSuggestions.Values.FontStyle.smallCaps
        ]
            
        case .codeLanguage: [
            PageflowSuggestions.Values.CodeLanguage.cucumber,
            PageflowSuggestions.Values.CodeLanguage.abap,
            PageflowSuggestions.Values.CodeLanguage.ada,
            PageflowSuggestions.Values.CodeLanguage.ahk,
            PageflowSuggestions.Values.CodeLanguage.antlr,
            PageflowSuggestions.Values.CodeLanguage.apacheconf,
            PageflowSuggestions.Values.CodeLanguage.applescript,
            PageflowSuggestions.Values.CodeLanguage.as,
            PageflowSuggestions.Values.CodeLanguage.aspectj,
            PageflowSuggestions.Values.CodeLanguage.autoit,
            PageflowSuggestions.Values.CodeLanguage.asy,
            PageflowSuggestions.Values.CodeLanguage.awk,
            PageflowSuggestions.Values.CodeLanguage.basemake,
            PageflowSuggestions.Values.CodeLanguage.bash,
            PageflowSuggestions.Values.CodeLanguage.bat,
            PageflowSuggestions.Values.CodeLanguage.bbcode,
            PageflowSuggestions.Values.CodeLanguage.befunge,
            PageflowSuggestions.Values.CodeLanguage.bmax,
            PageflowSuggestions.Values.CodeLanguage.boo,
            PageflowSuggestions.Values.CodeLanguage.brainfuck,
            PageflowSuggestions.Values.CodeLanguage.bro,
            PageflowSuggestions.Values.CodeLanguage.bugs,
            PageflowSuggestions.Values.CodeLanguage.c,
            PageflowSuggestions.Values.CodeLanguage.ceylon,
            PageflowSuggestions.Values.CodeLanguage.cfm,
            PageflowSuggestions.Values.CodeLanguage.cfs,
            PageflowSuggestions.Values.CodeLanguage.cheetah,
            PageflowSuggestions.Values.CodeLanguage.clj,
            PageflowSuggestions.Values.CodeLanguage.cmake,
            PageflowSuggestions.Values.CodeLanguage.cobol,
            PageflowSuggestions.Values.CodeLanguage.cl,
            PageflowSuggestions.Values.CodeLanguage.console,
            PageflowSuggestions.Values.CodeLanguage.control,
            PageflowSuggestions.Values.CodeLanguage.coq,
            PageflowSuggestions.Values.CodeLanguage.cpp,
            PageflowSuggestions.Values.CodeLanguage.croc,
            PageflowSuggestions.Values.CodeLanguage.csharp,
            PageflowSuggestions.Values.CodeLanguage.css,
            PageflowSuggestions.Values.CodeLanguage.cuda,
            PageflowSuggestions.Values.CodeLanguage.cyx,
            PageflowSuggestions.Values.CodeLanguage.d,
            PageflowSuggestions.Values.CodeLanguage.dg,
            PageflowSuggestions.Values.CodeLanguage.diff,
            PageflowSuggestions.Values.CodeLanguage.django,
            PageflowSuggestions.Values.CodeLanguage.dpatch,
            PageflowSuggestions.Values.CodeLanguage.duel,
            PageflowSuggestions.Values.CodeLanguage.dylan,
            PageflowSuggestions.Values.CodeLanguage.ec,
            PageflowSuggestions.Values.CodeLanguage.erb,
            PageflowSuggestions.Values.CodeLanguage.evoque,
            PageflowSuggestions.Values.CodeLanguage.fan,
            PageflowSuggestions.Values.CodeLanguage.fancy,
            PageflowSuggestions.Values.CodeLanguage.fortran,
            PageflowSuggestions.Values.CodeLanguage.gas,
            PageflowSuggestions.Values.CodeLanguage.genshi,
            PageflowSuggestions.Values.CodeLanguage.glsl,
            PageflowSuggestions.Values.CodeLanguage.gnuplot,
            PageflowSuggestions.Values.CodeLanguage.go,
            PageflowSuggestions.Values.CodeLanguage.gosu,
            PageflowSuggestions.Values.CodeLanguage.groovy,
            PageflowSuggestions.Values.CodeLanguage.gst,
            PageflowSuggestions.Values.CodeLanguage.haml,
            PageflowSuggestions.Values.CodeLanguage.haskell,
            PageflowSuggestions.Values.CodeLanguage.hxml,
            PageflowSuggestions.Values.CodeLanguage.html,
            PageflowSuggestions.Values.CodeLanguage.http,
            PageflowSuggestions.Values.CodeLanguage.hx,
            PageflowSuggestions.Values.CodeLanguage.idl,
            PageflowSuggestions.Values.CodeLanguage.irc,
            PageflowSuggestions.Values.CodeLanguage.ini,
            PageflowSuggestions.Values.CodeLanguage.java,
            PageflowSuggestions.Values.CodeLanguage.jade,
            PageflowSuggestions.Values.CodeLanguage.js,
            PageflowSuggestions.Values.CodeLanguage.json,
            PageflowSuggestions.Values.CodeLanguage.jsp,
            PageflowSuggestions.Values.CodeLanguage.kconfig,
            PageflowSuggestions.Values.CodeLanguage.koka,
            PageflowSuggestions.Values.CodeLanguage.lasso,
            PageflowSuggestions.Values.CodeLanguage.livescript,
            PageflowSuggestions.Values.CodeLanguage.llvm,
            PageflowSuggestions.Values.CodeLanguage.logos,
            PageflowSuggestions.Values.CodeLanguage.lua,
            PageflowSuggestions.Values.CodeLanguage.mako,
            PageflowSuggestions.Values.CodeLanguage.mason,
            PageflowSuggestions.Values.CodeLanguage.matlab,
            PageflowSuggestions.Values.CodeLanguage.minid,
            PageflowSuggestions.Values.CodeLanguage.monkey,
            PageflowSuggestions.Values.CodeLanguage.moon,
            PageflowSuggestions.Values.CodeLanguage.mxml,
            PageflowSuggestions.Values.CodeLanguage.myghty,
            PageflowSuggestions.Values.CodeLanguage.mysql,
            PageflowSuggestions.Values.CodeLanguage.nasm,
            PageflowSuggestions.Values.CodeLanguage.newlisp,
            PageflowSuggestions.Values.CodeLanguage.newspeak,
            PageflowSuggestions.Values.CodeLanguage.numpy,
            PageflowSuggestions.Values.CodeLanguage.ocaml,
            PageflowSuggestions.Values.CodeLanguage.octave,
            PageflowSuggestions.Values.CodeLanguage.ooc,
            PageflowSuggestions.Values.CodeLanguage.perl,
            PageflowSuggestions.Values.CodeLanguage.php,
            PageflowSuggestions.Values.CodeLanguage.plpgsql,
            PageflowSuggestions.Values.CodeLanguage.postgresql,
            PageflowSuggestions.Values.CodeLanguage.postscript,
            PageflowSuggestions.Values.CodeLanguage.pot,
            PageflowSuggestions.Values.CodeLanguage.prolog,
            PageflowSuggestions.Values.CodeLanguage.psql,
            PageflowSuggestions.Values.CodeLanguage.puppet,
            PageflowSuggestions.Values.CodeLanguage.python,
            PageflowSuggestions.Values.CodeLanguage.qml,
            PageflowSuggestions.Values.CodeLanguage.ragel,
            PageflowSuggestions.Values.CodeLanguage.raw,
            PageflowSuggestions.Values.CodeLanguage.ruby,
            PageflowSuggestions.Values.CodeLanguage.rhtml,
            PageflowSuggestions.Values.CodeLanguage.sass,
            PageflowSuggestions.Values.CodeLanguage.scheme,
            PageflowSuggestions.Values.CodeLanguage.smalltalk,
            PageflowSuggestions.Values.CodeLanguage.sql,
            PageflowSuggestions.Values.CodeLanguage.ssp,
            PageflowSuggestions.Values.CodeLanguage.tcl,
            PageflowSuggestions.Values.CodeLanguage.tea,
            PageflowSuggestions.Values.CodeLanguage.tex,
            PageflowSuggestions.Values.CodeLanguage.text,
            PageflowSuggestions.Values.CodeLanguage.vala,
            PageflowSuggestions.Values.CodeLanguage.vgl,
            PageflowSuggestions.Values.CodeLanguage.xml,
            PageflowSuggestions.Values.CodeLanguage.xquery,
            PageflowSuggestions.Values.CodeLanguage.yaml
        ]
            
        case .codeStyle: [
            PageflowSuggestions.Values.CodeStyle.manni,
            PageflowSuggestions.Values.CodeStyle.fruity,
            PageflowSuggestions.Values.CodeStyle.rrt,
            PageflowSuggestions.Values.CodeStyle.autumn,
            PageflowSuggestions.Values.CodeStyle.perldoc,
            PageflowSuggestions.Values.CodeStyle.bw,
            PageflowSuggestions.Values.CodeStyle.borland,
            PageflowSuggestions.Values.CodeStyle.emacs,
            PageflowSuggestions.Values.CodeStyle.colorful,
            PageflowSuggestions.Values.CodeStyle.vim,
            PageflowSuggestions.Values.CodeStyle.murphy,
            PageflowSuggestions.Values.CodeStyle.pastie,
            PageflowSuggestions.Values.CodeStyle.vs,
            PageflowSuggestions.Values.CodeStyle.friendly,
            PageflowSuggestions.Values.CodeStyle.trac,
            PageflowSuggestions.Values.CodeStyle.native,
            PageflowSuggestions.Values.CodeStyle.tango,
            PageflowSuggestions.Values.CodeStyle.monokai
        ]
            
        case .codeFrame: [
            PageflowSuggestions.Values.CodeFrame.lefline,
            PageflowSuggestions.Values.CodeFrame.topline,
            PageflowSuggestions.Values.CodeFrame.bottomline,
            PageflowSuggestions.Values.CodeFrame.lines,
            PageflowSuggestions.Values.CodeFrame.single
        ]
        }
    }
    
    // MARK: - Math Suggestions
    
    private static var mathSuggestions: [PageflowSuggestionEntry] {
        [
            PageflowSuggestions.Mathematics.alpha,
            PageflowSuggestions.Mathematics.beta,
            PageflowSuggestions.Mathematics.chi,
            PageflowSuggestions.Mathematics.delta,
            PageflowSuggestions.Mathematics.epsilon,
            PageflowSuggestions.Mathematics.eta,
            PageflowSuggestions.Mathematics.gamma,
            PageflowSuggestions.Mathematics.lambda,
            PageflowSuggestions.Mathematics.mu,
            PageflowSuggestions.Mathematics.nu,
            PageflowSuggestions.Mathematics.omega,
            PageflowSuggestions.Mathematics.phi,
            PageflowSuggestions.Mathematics.pi,
            PageflowSuggestions.Mathematics.psi,
            PageflowSuggestions.Mathematics.rho,
            PageflowSuggestions.Mathematics.sigma,
            PageflowSuggestions.Mathematics.tau,
            PageflowSuggestions.Mathematics.theta,
            PageflowSuggestions.Mathematics.upsilon,
            PageflowSuggestions.Mathematics.xi,
            PageflowSuggestions.Mathematics.varepsilon,
            PageflowSuggestions.Mathematics.varphi,
            PageflowSuggestions.Mathematics.vartheta,
            PageflowSuggestions.Mathematics.Delta,
            PageflowSuggestions.Mathematics.Gamma,
            PageflowSuggestions.Mathematics.Lambda,
            PageflowSuggestions.Mathematics.Omega,
            PageflowSuggestions.Mathematics.Phi,
            PageflowSuggestions.Mathematics.Pi,
            PageflowSuggestions.Mathematics.Psi,
            PageflowSuggestions.Mathematics.Sigma,
            PageflowSuggestions.Mathematics.Theta,
            PageflowSuggestions.Mathematics.frac,
            PageflowSuggestions.Mathematics.sqrt,
            PageflowSuggestions.Mathematics.sqrtn,
            PageflowSuggestions.Mathematics.overline,
            PageflowSuggestions.Mathematics.underline,
            PageflowSuggestions.Mathematics.widehat,
            PageflowSuggestions.Mathematics.widetilde,
            PageflowSuggestions.Mathematics.overrightarrow,
            PageflowSuggestions.Mathematics.overleftarrow,
            PageflowSuggestions.Mathematics.vert,
            PageflowSuggestions.Mathematics.Vert,
            PageflowSuggestions.Mathematics.langle,
            PageflowSuggestions.Mathematics.rangle,
            PageflowSuggestions.Mathematics.Uparrow,
            PageflowSuggestions.Mathematics.uparrow,
            PageflowSuggestions.Mathematics.Downarrow,
            PageflowSuggestions.Mathematics.downarrow,
            PageflowSuggestions.Mathematics.sum,
            PageflowSuggestions.Mathematics.prod,
            PageflowSuggestions.Mathematics.int,
            PageflowSuggestions.Mathematics.iint,
            PageflowSuggestions.Mathematics.iiint,
            PageflowSuggestions.Mathematics.arccos,
            PageflowSuggestions.Mathematics.cos,
            PageflowSuggestions.Mathematics.exp,
            PageflowSuggestions.Mathematics.min,
            PageflowSuggestions.Mathematics.arcsin,
            PageflowSuggestions.Mathematics.lg,
            PageflowSuggestions.Mathematics.ln,
            PageflowSuggestions.Mathematics.sup,
            PageflowSuggestions.Mathematics.arctan,
            PageflowSuggestions.Mathematics.lim,
            PageflowSuggestions.Mathematics.log,
            PageflowSuggestions.Mathematics.tan,
            PageflowSuggestions.Mathematics.arg,
            PageflowSuggestions.Mathematics.inf,
            PageflowSuggestions.Mathematics.max,
            PageflowSuggestions.Mathematics.sin,
            PageflowSuggestions.Mathematics.ast,
            PageflowSuggestions.Mathematics.circ,
            PageflowSuggestions.Mathematics.bullet,
            PageflowSuggestions.Mathematics.times,
            PageflowSuggestions.Mathematics.div,
            PageflowSuggestions.Mathematics.pm,
            PageflowSuggestions.Mathematics.odot,
            PageflowSuggestions.Mathematics.ominus,
            PageflowSuggestions.Mathematics.oplus,
            PageflowSuggestions.Mathematics.otimes,
            PageflowSuggestions.Mathematics.cap,
            PageflowSuggestions.Mathematics.cup,
            PageflowSuggestions.Mathematics.equiv,
            PageflowSuggestions.Mathematics.cong,
            PageflowSuggestions.Mathematics.sim,
            PageflowSuggestions.Mathematics.simeq,
            PageflowSuggestions.Mathematics.approx,
            PageflowSuggestions.Mathematics.leq,
            PageflowSuggestions.Mathematics.ll,
            PageflowSuggestions.Mathematics.subset,
            PageflowSuggestions.Mathematics.subseteq,
            PageflowSuggestions.Mathematics.in,
            PageflowSuggestions.Mathematics.geq,
            PageflowSuggestions.Mathematics.gg,
            PageflowSuggestions.Mathematics.supset,
            PageflowSuggestions.Mathematics.supseteq,
            PageflowSuggestions.Mathematics.ni,
            PageflowSuggestions.Mathematics.notin,
            PageflowSuggestions.Mathematics.approxeq,
            PageflowSuggestions.Mathematics.leftarrow,
            PageflowSuggestions.Mathematics.Leftarrow,
            PageflowSuggestions.Mathematics.rightarrow,
            PageflowSuggestions.Mathematics.Rightarrow,
            PageflowSuggestions.Mathematics.leftrightarrow,
            PageflowSuggestions.Mathematics.Leftrightarrow,
            PageflowSuggestions.Mathematics.longleftarrow,
            PageflowSuggestions.Mathematics.Longleftarrow,
            PageflowSuggestions.Mathematics.longrightarrow,
            PageflowSuggestions.Mathematics.Longrightarrow,
            PageflowSuggestions.Mathematics.longleftrightarrow,
            PageflowSuggestions.Mathematics.Longleftrightarrow,
            PageflowSuggestions.Mathematics.updownarrow,
            PageflowSuggestions.Mathematics.Updownarrow,
            PageflowSuggestions.Mathematics.infty,
            PageflowSuggestions.Mathematics.nabla,
            PageflowSuggestions.Mathematics.partial,
            PageflowSuggestions.Mathematics.forall,
            PageflowSuggestions.Mathematics.exists,
            PageflowSuggestions.Mathematics.nexists,
            PageflowSuggestions.Mathematics.emptyset,
            PageflowSuggestions.Mathematics.varnothing,
            PageflowSuggestions.Mathematics.tilde,
            PageflowSuggestions.Mathematics.ddot,
            PageflowSuggestions.Mathematics.bar,
            PageflowSuggestions.Mathematics.dot,
            PageflowSuggestions.Mathematics.hat,
            PageflowSuggestions.Mathematics.vec
        ]
    }
    
    // MARK: - Constant Suggestions
    
    private static var constantSuggestions: [PageflowSuggestionEntry] {
        [
            PageflowSuggestions.Constants.width,
            PageflowSuggestions.Constants.height
        ]
    }
    
    // MARK: - Boolean Suggestions
    
    private static var booleanSuggestions: [PageflowSuggestionEntry] {
        [
            PageflowSuggestions.Booleans.true,
            PageflowSuggestions.Booleans.false
        ]
    }
    
    // MARK: - File Suggestions
    
    private static func fileSuggestions(
        for type: PageflowSuggestionContext.FileTypes,
        provider: FileSuggestionsProvider?
    ) -> [PageflowSuggestionEntry]? {
        guard let provider else { return nil }
        
        switch type {
        case .image:
            let images = provider.images
            
            return images.map { name in
                PageflowSuggestionEntry(
                    label: name,
                    image: Image(systemName: "i.square.fill"),
                    imageColor: .blue,
                    insertText: name
                )
            }
            
        case .listing:
            let listings = provider.listings
            
            return listings.map { name in
                PageflowSuggestionEntry(
                    label: name,
                    image: Image(systemName: "l.square.fill"),
                    imageColor: .blue,
                    insertText: name
                )
            }
        }
    }
}
