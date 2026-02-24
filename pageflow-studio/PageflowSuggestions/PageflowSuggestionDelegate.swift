//
//  PageflowSuggestionDelegate.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 16.02.2026.
//

import SwiftUI
import Combine
import Rearrange

import PageflowSourceEditor
import PageflowLanguage
import CodeEditTextView

import SwiftTreeSitter
import TreeSitter

final class PageflowSuggestionDelegate: CodeSuggestionDelegate, ObservableObject {
    
    // MARK: - Private Properties
    
    private var lastPosition: CursorPosition?
    
    // MARK: - Internal Methods
    
    func completionSuggestionsRequested(
        textView: TextViewController,
        cursorPosition: CursorPosition
    ) async -> (windowPosition: CursorPosition, items: [CodeSuggestionEntry])? {
        try? await Task.sleep(for: .milliseconds(50))
        
        lastPosition = cursorPosition
        
        guard let (context, range) = context(textView: textView, cursorPosition: cursorPosition),
              let suggestions = suggestions(
                context: context,
                filter: textView.textView.substring(from: range)
              )
        else {
            return nil
        }
        
        return (cursorPosition, suggestions)
    }
    
    func completionOnCursorMove(
        textView: TextViewController,
        cursorPosition: CursorPosition
    ) -> [CodeSuggestionEntry]? {
        guard let position = lastPosition,
              abs(position.range.location - cursorPosition.range.location) == 1
        else {
            lastPosition = nil
            return nil
        }
        
        lastPosition = cursorPosition
        
        guard let (context, range) = context(textView: textView, cursorPosition: cursorPosition),
              let suggestions = suggestions(
                context: context,
                filter: textView.textView.substring(from: range)
              )
        else {
            return nil
        }
        
        return suggestions
    }
    
    func completionWindowApplyCompletion(
        item: CodeSuggestionEntry,
        textView: TextViewController,
        cursorPosition: CursorPosition?
    ) {
        guard let suggestion = item as? PageflowSuggestionEntry,
              let cursorPosition
        else {
            return
        }
        
        guard let tree = textView.treeSitterClient?.state?.tree,
              let root = tree.rootNode,
              let node = root.namedDescendant(
                for: cursorPosition.range.location,
                in: textView
              )
        else {
            return
        }
        
        textView.textView.undoManager?.beginUndoGrouping()
        textView.textView.selectionManager.setSelectedRange(node.range)
        
        textView.textView.insertText(suggestion.insertText)
        textView.textView.undoManager?.endUndoGrouping()
        
        let offset = cursorPosition.range.location - node.range.length
                     + suggestion.insertText.count - (suggestion.cursorOffset ?? 0)
        
        let range = NSRange(location: offset, length: 0)
        let position = CursorPosition(range: range)
        
        textView.setCursorPositions([position])
    }
}

// MARK: - Extensions

extension PageflowSuggestionDelegate {
    
    // MARK: - Private Methods
    
    private func context(
        textView: TextViewController,
        cursorPosition: CursorPosition
    ) -> (context: PageflowSuggestionContext, range: NSRange)? {
        guard let tree = textView.treeSitterClient?.state?.tree,
              let root = tree.rootNode,
              let node = root.namedDescendant(
                for: cursorPosition.range.location,
                in: textView
              ),
              let block = parentBlock(of: node)
        else {
            return nil
        }
        
        print(node.nodeType as Any)
        debug(tree: tree)
        
        switch block {
        case "source_file":
            return (.content(.root), node.range)
            
        case "newpage_block":
            return (.content(.newPage), node.range)
            
        case "section_newpage_block":
            return (.content(.sectionNewPage), node.range)
            
        case "section_block":
            return (.content(.section), node.range)
            
        case "subsection_block":
            return (.content(.subSection), node.range)
            
        case "vstack_block":
            return (.content(.vStack), node.range)
            
        case "hstack_block":
            return (.content(.hStack), node.range)
            
        case "zstack_block":
            return (.content(.zStack), node.range)
            
        case "text_block", "math_block",
             "image_element", "listing_element",
             "spacer_element", "divider_element":
            // TODO
            return nil
            
        default:
            return nil
        }
    }
    
    private func suggestions(
        context: PageflowSuggestionContext,
        filter prefix: String? = nil
    ) -> [PageflowSuggestionEntry]? {
        guard context != .text && context != .file else {
            return nil
        }
        
        let suggestions = PageflowSuggestions.suggestions(for: context)
        
        if let prefix, prefix.count > 0 {
            return suggestions.filter { $0.label.hasPrefix(prefix) }
            
        } else {
            return suggestions
        }
    }
    
    private func parentBlock(of node: Node) -> String? {
        guard let parent = node.parent,
              let parentType = parent.nodeType
        else {
            return nil
        }
        
        switch parentType {
        case "source_file", "newpage_block", "section_newpage_block",
             "section_block", "subsection_block",
             "vstack_block", "hstack_block", "zstack_block",
             "text_block", "math_block",
             "image_element", "listing_element",
             "spacer_element", "divider_element":
            return parentType
            
        default:
            return parentBlock(of: parent)
        }
    }
}

// MARK: - Private Extensions

private extension Node {
    
    // MARK: - Internal Methods
    
    func namedDescendant(for location: Int, in textView: TextViewController) -> Node? {
        guard contains(location, in: textView) else {
            return nil
        }
        
        for i in 0..<namedChildCount {
            guard let child = namedChild(at: i) else {
                continue
            }
            
            if child.contains(location, in: textView) {
                return child.namedDescendant(for: location, in: textView)
            }
        }
        
        return self
    }
    
    // MARK: - Support Methods
    
    func contains(_ location: Int, in textView: TextViewController) -> Bool {
        let byteOffset = textView.byteOffsetForLocation(location)
        return byteRange.contains(byteOffset) || byteRange.upperBound == byteOffset
    }
}

private extension TextViewController {
    
    // MARK: - Internal Methods
    
    func byteOffsetForLocation(_ location: Int) -> UInt32 {
        let index = String.Index(utf16Offset: location, in: text)
        let offset = text.utf16.distance(from: text.utf16.startIndex, to: index)
        let bytes = max(0, offset * 2 - 2)
        
        return UInt32(bytes)
    }
}

extension PageflowSuggestionDelegate {
    
    private func debug(tree: Tree) {
        print(String(repeating: "=", count: 60))
        print("PARSED TREE")
        print(String(repeating: "=", count: 60))
        
        if let root = tree.rootNode {
            debug(node: root)
        }
        
        print(String(repeating: "=", count: 60))
    }
    
    private func debug(node: Node, indent: String = "") {
        let type = node.nodeType ?? "unknown"
        let range = node.byteRange
        let pointRange = node.pointRange
        
        print("\(indent)\(type) [\(range.lowerBound)-\(range.upperBound)]")
        
        for i in 0..<node.childCount {
            guard let child = node.child(at: i) else { continue }
            debug(node: child, indent: indent + "  ")
        }
    }
}
