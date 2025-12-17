//
//  STTextViewSystemInterface.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 03.12.2025.
//

import Neon
import Cocoa

import STTextView
import STTextKitPlus

import Rearrange
import RangeState

import SwiftTreeSitterLayer

@MainActor
struct STTextViewSystemInterface: TextSystemInterface {
    
    // MARK: - Internal Properties
    
    var content: NSTextContentManager { interface.content }
    
    var string: String { interface.string }
    
    // MARK: - Private Properties
    
    private let interface: STTextLayoutManagerSystemInterface
    
    // MARK: - Initializers
    
    init(
        textView: STTextView,
        attributeProvider: @escaping TokenAttributeProvider
    ) {
        self.interface = STTextLayoutManagerSystemInterface(
            textLayoutManager: textView.textLayoutManager,
            textContentManager: textView.textContentManager,
            attributeProvider: attributeProvider
        )
    }
    
    // MARK: - Internal Methods
    
    func applyStyles(for application: TokenApplication) {
        interface.applyStyles(for: application)
    }
    
    func languageLayerContent(with limit: Int) -> LanguageLayer.Content {
        LanguageLayer.Content(string: interface.string, limit: limit)
    }

    func languageLayerContentSnapshot(with limit: Int) -> LanguageLayer.ContentSnapshot {
        LanguageLayer.ContentSnapshot(string: interface.string, limit: limit)
    }
}

@MainActor
private struct STTextLayoutManagerSystemInterface: TextSystemInterface {
    
    // MARK: - Internal Properties
    
    var content: NSTextContentManager { textContentManager }
    
    var string: String {
        textContentManager
            .attributedString(in: nil)
            .flatMap { $0.string }
            .unwrap { "" }
    }
    
    // MARK: - Private Properties
    
    private let textLayoutManager: NSTextLayoutManager
    private let textContentManager: NSTextContentManager
    private let attributeProvider: TokenAttributeProvider
    
    // MARK: - Initializers
    
    init(
        textLayoutManager: NSTextLayoutManager,
        textContentManager: NSTextContentManager,
        attributeProvider: @escaping TokenAttributeProvider
    ) {
        self.textLayoutManager = textLayoutManager
        self.textContentManager = textContentManager
        self.attributeProvider = attributeProvider
    }

    // MARK: - Internal Methods
    
    func applyStyles(for application: TokenApplication) {
        if let range = application.range {
            setAttributes([:], in: range)
        }

        for token in application.tokens {
            let attrs = attributeProvider(token)
            setAttributes(attrs, in: token.range)
        }
    }
    
    // MARK: - Private Methods
    
    private func setAttributes(_ attrs: [NSAttributedString.Key : Any], in range: NSRange) {
        let length = NSRange(
            textContentManager.documentRange,
            provider: textContentManager
        ).length
        
        let clampedRange = range.clamped(to: length)

        guard let textRange = NSTextRange(
            clampedRange,
            provider: textContentManager
        ) else {
            return
        }

        textLayoutManager.setRenderingAttributes(attrs, for: textRange)
    }
}
