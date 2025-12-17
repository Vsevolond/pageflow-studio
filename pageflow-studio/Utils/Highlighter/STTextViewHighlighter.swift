//
//  STTextViewHighlighter.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 03.12.2025.
//

import Neon
import Cocoa
import RangeState

import SwiftTreeSitter
import SwiftTreeSitterLayer
import TreeSitterClient

import STTextView
import STTextKitPlus

@MainActor
final class STTextViewHighlighter {
    
    // MARK: - Type Entities
    
    private typealias Styler = TextSystemStyler<STTextViewSystemInterface>
    
    // MARK: - Configuration
    
    struct Configuration {
        
        // MARK: - Internal Properties
        
        let languageConfiguration: LanguageConfiguration
        let attributeProvider: TokenAttributeProvider
        let languageProvider: LanguageLayer.LanguageProvider
        let locationTransformer: Point.LocationTransformer

        // MARK: - Initializers
        
        init(
            languageConfiguration: LanguageConfiguration,
            attributeProvider: @escaping TokenAttributeProvider,
            languageProvider: @escaping LanguageLayer.LanguageProvider = { _ in nil },
            locationTransformer: @escaping Point.LocationTransformer
        ) {
            self.languageConfiguration = languageConfiguration
            self.attributeProvider = attributeProvider
            self.languageProvider = languageProvider
            self.locationTransformer = locationTransformer
        }
    }
    
    // MARK: - Private Properties

    private let textView: STTextView
    private let configuration: Configuration
    private let styler: Styler
    private let interface: STTextViewSystemInterface
    private let client: TreeSitterClient
    private let buffer = RangeInvalidationBuffer()
    
    init(textView: STTextView, configuration: Configuration) throws {
        self.textView = textView
        self.configuration = configuration
        
        self.interface = STTextViewSystemInterface(
            textView: textView,
            attributeProvider: configuration.attributeProvider
        )
        
        let clientConfiguration = TreeSitterClient.Configuration(
            languageProvider: configuration.languageProvider,
            contentProvider: { [interface] in
                interface.languageLayerContent(with: $0)
            },
            contentSnapshopProvider: { [interface] in
                interface.languageLayerContentSnapshot(with: $0)
            },
            lengthProvider: { [interface] in
                interface.content.currentLength
            },
            invalidationHandler: { [buffer] in
                buffer.invalidate(.set($0))
            },
            locationTransformer: configuration.locationTransformer
        )
        
        self.client = try TreeSitterClient(
            rootLanguageConfig: configuration.languageConfiguration,
            configuration: clientConfiguration
        )

        let tokenProvider = client.tokenProvider(with: { [interface] in
            interface.string.predicateTextProvider($0, $1)
        })

        self.styler = TextSystemStyler(
            textSystem: interface,
            tokenProvider: tokenProvider
        )

        buffer.invalidationHandler = { [styler] in
            styler.invalidate($0)
            styler.validate()
        }

        invalidate(.all)
    }
    
    // MARK: - Internal Methods
    
    func willChangeContent(in range: NSRange) {
        buffer.beginBuffering()
        client.willChangeContent(in: range)
    }
    
    func didChangeContent(in range: NSRange, delta: Int) {
        client.didChangeContent(in: range, delta: delta)
        styler.didChangeContent(in: range, delta: delta)
        
        buffer.endBuffering()
    }
    
    func updateVisibleRange(_ textRange: NSTextRange) {
        let range = NSRange(textRange, in: textView.textContentManager)
        styler.validate(.range(range))
    }

    func invalidate(_ target: RangeTarget) {
        buffer.invalidate(target)
    }
}
