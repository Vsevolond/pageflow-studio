//
//  PageflowSuggestionEntry.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.02.2026.
//

import SwiftUI
import PageflowSourceEditor

struct PageflowSuggestionEntry: CodeSuggestionEntry {
    
    // MARK: - Internal Properties
    
    var label: String
    var detail: String?
    var image: Image
    var imageColor: Color
    
    var insertText: String
    var cursorOffset: Int?
    
    var documentation: String? { nil }
    var sourcePreview: String? { insertText }
    var pathComponents: [String]? { nil }
    var targetPosition: CursorPosition? { nil }
    var deprecated: Bool { false }
    
    // MARK: - Initializers
    
    init(
        label: String,
        detail: String? = nil,
        image: Image,
        imageColor: Color,
        insertText: String,
        cursorOffset: Int? = nil
    ) {
        self.label = label
        self.insertText = insertText
        self.detail = detail
        self.image = image
        self.imageColor = imageColor
        self.cursorOffset = cursorOffset
    }
}
