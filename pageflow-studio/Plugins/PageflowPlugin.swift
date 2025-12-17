//
//  PageflowPlugin.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 02.12.2025.
//

import Cocoa
import SwiftUI
import Rearrange

import STTextView
import STTextKitPlus

import SwiftTreeSitter
import TreeSitterClient
import SwiftTreeSitterLayer

import Neon
import RangeState

struct PageflowPlugin: STPlugin {
    
    // MARK: - Private Properties
    
    private let theme: Theme
    private let queriesURL: URL
    
    // MARK: - Initializers
    
    init(theme: Theme, queriesURL: URL) {
        self.theme = theme
        self.queriesURL = queriesURL
    }
    
    // MARK: - Internal Methods
    
    func setUp(context: any Context) {
        context.events.onWillChangeText { affectedRange, _ in
            let range = NSRange(affectedRange, in: context.textView.textContentManager)
            context.coordinator.willChangeContent(in: range)
        }
        
        context.events.onDidChangeText { affectedRange, replacementString in
            guard let replacementString else { return }
            let range = NSRange(affectedRange, in: context.textView.textContentManager)
            
            context.coordinator.didChangeContent(
                in: range,
                delta: replacementString.utf16.count - range.length
            )
        }
        
        context.events.onDidLayoutViewport { viewportRange in
            context.coordinator.updateViewportRange(viewportRange)
        }
    }
    
    func makeCoordinator(context: CoordinatorContext) -> Coordinator {
        Coordinator(textView: context.textView, theme: theme, queriesURL: queriesURL)
    }
}

// MARK: - Extensions

extension PageflowPlugin {
    
    // MARK: - Coordinator
    
    @MainActor
    final class Coordinator {
        
        // MARK: - Private Properties
        
        private let theme: Theme
        
        private let highighter: STTextViewHighlighter?
        private var prevViewportRange: NSTextRange? = nil
        
        // MARK: - Initializers
        
        init(textView: STTextView, theme: Theme, queriesURL: URL) {
            self.theme = theme
            
            do {
                let languageConfiguration = try LanguageConfiguration(
                    tree_sitter_pageflow(),
                    name: "PageFlow",
                    queriesURL: queriesURL
                )
                
                let attributeProvider: TokenAttributeProvider = { token in
                    var attributes: [NSAttributedString.Key : Any] = [:]
                    attributes[.font] = textView.font
                    
                    if let color = theme.color(for: token.name) {
                        attributes[.foregroundColor] = NSColor(color)
                    }
                    
                    return attributes
                }
                
                let locationTransformer: Point.LocationTransformer = { [textView] index in
                    guard let textLocation = textView.textContentManager.location(at: index),
                          let position = textView.textContentManager.position(textLocation)
                    else {
                        return nil
                    }
                    
                    return Point(row: position.row, column: position.column)
                    
                }
                
                let configuration = STTextViewHighlighter.Configuration(
                    languageConfiguration: languageConfiguration,
                    attributeProvider: attributeProvider,
                    locationTransformer: locationTransformer
                )
                
                let highlighter = try STTextViewHighlighter(
                    textView: textView,
                    configuration: configuration
                )
                self.highighter = highlighter
                
                highlighter.willChangeContent(
                    in: NSRange(
                        textView.textContentManager.documentRange,
                        in: textView.textContentManager
                    )
                )
                highlighter.didChangeContent(
                    in: NSRange(
                        textView.textContentManager.documentRange,
                        in: textView.textContentManager
                    ),
                    delta: textView.textContentManager.length
                )
                
                highlighter.invalidate(.all)
                
            } catch {
                self.highighter = nil
            }
        }
        
        // MARK: - Internal Methods
        
        func willChangeContent(in range: NSRange) {
            guard let highighter else { return }
            
            highighter.willChangeContent(in: range)
        }
        
        func didChangeContent(in range: NSRange, delta: Int) {
            guard let highighter else { return }
            
            highighter.didChangeContent(in: range, delta: delta)
        }
        
        func updateViewportRange(_ visibleRange: NSTextRange?) {
            guard let highighter, let visibleRange,
                  visibleRange != prevViewportRange
            else {
                return
            }
            
            prevViewportRange = visibleRange
            highighter.updateVisibleRange(visibleRange)
        }
    }
}
