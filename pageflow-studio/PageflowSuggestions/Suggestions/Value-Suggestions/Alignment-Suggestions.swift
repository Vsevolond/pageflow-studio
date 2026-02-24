//
//  Alignment-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions {
    
    // MARK: - Value Suggestions
    
    enum Values {
        
        // MARK: - Alignment Suggestions
        
        enum Alignment {
            
            static var center: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "center",
                    detail: "По центру",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "center"
                )
            }
            
            static var leading: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "leading",
                    detail: "По левой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "leading"
                )
            }
            
            static var trailing: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "trailing",
                    detail: "По правой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "trailing"
                )
            }
            
            static var top: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "top",
                    detail: "По верхней стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "top"
                )
            }
            
            static var bottom: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "bottom",
                    detail: "По нижней стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "bottom"
                )
            }
            
            static var topLeading: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "topLeading",
                    detail: "По верхней и левой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "topLeading"
                )
            }
            
            static var topTrailing: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "topTrailing",
                    detail: "По верхней и правой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "topTrailing"
                )
            }
            
            static var bottomLeading: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "bottomLeading",
                    detail: "По нижней и левой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "bottomLeading"
                )
            }
            
            static var bottomTrailing: PageflowSuggestionEntry {
                PageflowSuggestionEntry(
                    label: "bottomTrailing",
                    detail: "По нижней и правой стороне",
                    image: Image(systemName: "a.square.fill"),
                    imageColor: .blue,
                    insertText: "bottomTrailing"
                )
            }
        }
    }
}
