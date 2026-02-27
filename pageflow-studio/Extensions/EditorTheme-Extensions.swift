//
//  EditorTheme-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import AppKit
import PageflowSourceEditor

extension EditorTheme {
    
    static let light = EditorTheme(
        text: Attribute(color: .init(hex: "262626")),               // black
        insertionPoint: .black,
        invisibles: Attribute(color: .init(hex: "D6D6D6")),
        background: .init(hex: "FFFFFF"),
        lineHighlight: .init(hex: "ECF5FF"),
        selection: .init(hex: "B2D7FF"),
        blocks: Attribute(color: .init(hex: "4624A9"), bold: true), // violet
        modifiers: Attribute(color: .init(hex: "7951B2")),          // light violet
        typeValues: Attribute(color: .init(hex: "4624A9")),         // violet
        numbers: Attribute(color: .init(hex: "2729CF")),            // blue
        constants: Attribute(color: .init(hex: "296188")),          // teal
        booleans: Attribute(color: .init(hex: "A0459F")),           // pink
        strings: Attribute(color: .init(hex: "C13E2A")),            // red
        mathStrings: Attribute(color: .init(hex: "4F7E86")),        // light green
        fileStrings: Attribute(color: .init(hex: "31565B")),        // green
        textSeparator: Attribute(color: .init(hex: "367AAB")),      // cyan
        textDelimiter: Attribute(color: .init(hex: "C13E2A")),      // red
        mathDelimiter: Attribute(color: .init(hex: "4F7E86")),      // light green
        identifiers: Attribute(color: .init(hex: "31565B")),        // green
        invalids: Attribute(color: .init(hex: "262626"))            // black
    )
    
    static let dark = EditorTheme(
        text: Attribute(color: .init(hex: "DFDFE0")),               // white
        insertionPoint: .init(hex: "007AFF"),
        invisibles: Attribute(color: .init(hex: "53606E")),
        background: .init(hex: "292A2F"),
        lineHighlight: .init(hex: "2F3239"),
        selection: .init(hex: "646F83"),
        blocks: Attribute(color: .init(hex: "D5BBFA"), bold: true), // light violet
        modifiers: Attribute(color: .init(hex: "AA84E5")),          // violet
        typeValues: Attribute(color: .init(hex: "D5BBFA")),         // light violet
        numbers: Attribute(color: .init(hex: "D6C986")),            // yellow
        constants: Attribute(color: .init(hex: "89DCFB")),          // cyan
        booleans: Attribute(color: .init(hex: "EE81B0")),           // pink
        strings: Attribute(color: .init(hex: "EF8876")),            // red
        mathStrings: Attribute(color: .init(hex: "89C0B3")),        // green
        fileStrings: Attribute(color: .init(hex: "BBF0E4")),        // light green
        textSeparator: Attribute(color: .init(hex: "69AEC8")),      // blue
        textDelimiter: Attribute(color: .init(hex: "EF8876")),      // red
        mathDelimiter: Attribute(color: .init(hex: "89C0B3")),      // green
        identifiers: Attribute(color: .init(hex: "BBF0E4")),        // light green
        invalids: Attribute(color: .init(hex: "DFDFE0"))            // white
    )
}
