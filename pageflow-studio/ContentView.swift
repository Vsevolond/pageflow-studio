//
//  ContentView.swift
//  pageflow-studio
//
//  Created by Всеволод Донченко on 11.11.2025.
//

import SwiftUI
import STTextViewSwiftUI

import TextFormation
import TextFormationPlugin

import STAnnotationsPlugin
import STAnnotationsPluginAppKit

struct ContentView: View {
    @State private var text: AttributedString = ""
    
    private let queriesURL: URL

    private let provider = TextualIndenter(
        patterns: [
            PreceedingLineSuffixIndenter(suffix: "{"),
            CurrentLinePrefixOutdenter(prefix: "}"),
            PreceedingLineSuffixIndenter(suffix: "("),
            CurrentLinePrefixOutdenter(prefix: ")")
        ],
        referenceLinePredicate: TextualIndenter.nonEmptyLineWithoutPrefixPredicate(
            prefix: "."
        )
    )
    .substitionProvider(indentationUnit: "    ", width: 4)
    
    init(queriesURL: URL) {
        self.queriesURL = queriesURL
    }
    
    var body: some View {
        TextView(
            text: $text,
            options: [.showLineNumbers, .wrapLines, .highlightSelectedLine],
            plugins: [
                PageflowPlugin(theme: .light, queriesURL: queriesURL),
                TextFormationPlugin(
                    filters: [
                        OpenPairFilter(open: "{", close: "}"),
                        OpenPairFilter(open: "(", close: ")"),
                        OpenPairFilter(open: "$", close: "$"),
                        NewlineProcessingFilter()
                        
                    ],
                    whitespaceProviders: WhitespaceProviders(
                        leadingWhitespace: { range, interface in
                            provider(range, interface)
                        },
                        trailingWhitespace: { _, _ in "" }
                    )
                )
            ]
        )
        .textViewFont(
            .monospacedSystemFont(
                ofSize: 16,
                weight: .regular
            )
        )
    }
    
    private func OpenPairFilter(open: String, close: String) -> Filter {
        CompositeFilter(
            filters: [
                LineLeadingWhitespaceFilter(string: close),
                ClosePairFilter(open: open, close: close),
                NewlineWithinPairFilter(open: open, close: close),
                OpenPairReplacementFilter(open: open, close: close),
                DeleteCloseFilter(open: open, close: close)
            ]
        ) { _, action in
            switch action {
            case .stop, .none:
                return .none
            case .discard:
                return .discard
            }
        }
    }
}
