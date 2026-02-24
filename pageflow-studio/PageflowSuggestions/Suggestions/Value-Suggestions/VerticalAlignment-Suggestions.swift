//
//  VerticalAlignment-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - VerticalAlignment Suggestions
    
    enum VerticalAlignment {
        
        static var center: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "center",
                detail: "По центру",
                image: Image(systemName: "v.square.fill"),
                imageColor: .blue,
                insertText: "center"
            )
        }
        
        static var top: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "top",
                detail: "По верхней стороне",
                image: Image(systemName: "v.square.fill"),
                imageColor: .blue,
                insertText: "top"
            )
        }
        
        static var bottom: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "bottom",
                detail: "По нижней стороне",
                image: Image(systemName: "v.square.fill"),
                imageColor: .blue,
                insertText: "bottom"
            )
        }
    }
}
