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
    
    func completionTriggerCharacters() -> Set<String> {
        [".", "@", "\\"]
    }
    
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
              let node = root.namedDescendant(for: cursorPosition.range.location, in: textView),
              let (_, nodeRange) = context(textView: textView, cursorPosition: cursorPosition)
        else {
            return
        }
        
        textView.textView.undoManager?.beginUndoGrouping()
        textView.textView.selectionManager.setSelectedRange(nodeRange.isEmpty ? cursorPosition.range : node.range)
        
        textView.textView.insertText(suggestion.insertText)
        textView.textView.undoManager?.endUndoGrouping()
        
        let offset = cursorPosition.range.location - nodeRange.length
                     + suggestion.insertText.count - (suggestion.cursorOffset ?? 0)
        
        let range = NSRange(location: offset, length: 0)
        let position = CursorPosition(range: range)
        
        textView.setCursorPositions([position])
    }
}

// MARK: - Extensions

extension PageflowSuggestionDelegate {
    
    /// Returns context for cursor position
    private func context(
        textView: TextViewController,
        cursorPosition: CursorPosition
    ) -> (context: PageflowSuggestionContext, range: NSRange)? {
        guard let tree = textView.treeSitterClient?.state?.tree,
              let root = tree.rootNode,
              let node = root.namedDescendant(for: cursorPosition.range.location, in: textView)
        else {
            return nil
        }
        
        debug(tree: tree)
        
        /// when typed any letter after dot for block
        if let prevSibling = node.previousSibling, prevSibling.nodeType == "." {
            /// block modifier
            guard let parent = node.parent,
                  let context = modifierContext(for: parent.previousNamedSibling)
            else {
                return nil
            }
            
            return (context, node.range)
        
        /// when typed dot after block
        } else if let firstChild = node.firstChild, node.childCount == 1, firstChild.nodeType == "." {
            /// block modifier
            guard let context = modifierContext(for: node.previousNamedSibling) else {
                return nil
            }
            
            return (context, .zero)
            
        /// when typed dot for type value or typed @ in expression
        } else if let child = node.descendant(for: cursorPosition.range.location, in: textView, subOnly: true),
                  child.nodeType == "." || child.nodeType == "@"
        {
            switch child.nodeType {
            /// type value
            case ".":
                guard let context = valueContext(for: child.parent) else {
                    return nil
                }
                
                return (context, .zero)
            
            /// constant
            case "@":
                guard let context = constantContext(for: child.parent) else {
                    return nil
                }
                
                return (context, .zero)
                
            default:
                return nil
            }
        
        /// when typed any letter after dot for type value
        } else if let parent = node.parent,
                  let prevNode = parent.previousSibling,
                  prevNode.nodeType == "."
        {
            /// type value
            guard let context = valueContext(for: prevNode.parent) else {
                return nil
            }
            
            return (context, node.range)
        
        /// when typed any letter after @ for constant
        } else if let prevNode = node.previousSibling,
                  prevNode.nodeType == "@"
        {
            /// constant
            guard let context = constantContext(for: prevNode.parent) else {
                return nil
            }
            
            return (context, node.range)
            
        /// when typed any letter inside content block
        } else {
            /// content block
            let block = parentBlock(of: node)
            
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
    }
    
    /// Returns filtered suggestions
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
    
    /// Returns modifier context for block
    private func modifierContext(for node: Node?) -> PageflowSuggestionContext? {
        guard let node else { return nil }
        
        switch node.nodeType {
        case "element", "newpage_content", "section_newpage_content",
            "section_content", "content":
            let block = childBlock(of: node)
            
            switch block {
            case "newpage_block", "section_newpage_block":
                return .modifier(.newPage)
                
            case "section_block", "subsection_block", "spacer_element":
                return nil
                
            case "vstack_block":
                return .modifier(.vStack)
                
            case "hstack_block":
                return .modifier(.hStack)
                
            case "zstack_block":
                return .modifier(.zStack)
                
            case "text_block":
                return .modifier(.text)
                
            case "math_block":
                return .modifier(.math)
                
            case "image_element":
                return .modifier(.image)
                
            case "listing_element":
                return .modifier(.listing)
                
            case "divider_element":
                return .modifier(.divider)
                
            default:
                return nil
            }
            
        default:
            return nil
        }
    }
    
    /// Returns value context for type
    private func valueContext(for node: Node?) -> PageflowSuggestionContext? {
        guard let node else { return nil }
        
        switch node.nodeType {
        case "horizontal_alignment_type":
            return .value(.horizontalAlignment)

        case "vertical_alignment_type":
            return .value(.verticalAlignment)
            
        case "alignment_type":
            return .value(.alignment)
            
        case "edge_type":
            return .value(.edge)
            
        case "axis_type":
            return .value(.axis)
            
        case "color_type":
            return .value(.color)
            
        case "line_pattern_type":
            return .value(.linePattern)
            
        case "font_size_type":
            return .value(.fontSize)
            
        case "font_style_type":
            return .value(.fontStyle)
            
        case "code_language_type":
            return .value(.codeLanguage)
            
        case "code_style_type":
            return .value(.codeStyle)
            
        case "code_frame_type":
            return .value(.codeFrame)
            
        default:
            return nil
        }
    }
    
    /// Returns constant context for node
    private func constantContext(for node: Node?) -> PageflowSuggestionContext? {
        guard let node else { return nil }
        
        switch node.nodeType {
        case "constant":
            return .constant
            
        default:
            return nil
        }
    }
    
    /// Returns parent block for node
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
    
    /// Returns child block for node
    private func childBlock(of parent: Node) -> String? {
        for i in 0..<parent.namedChildCount {
            guard let child = parent.namedChild(at: i),
                  let type = child.nodeType
            else {
                continue
            }
            
            switch type {
            case "newpage_block", "section_newpage_block",
                 "section_block", "subsection_block",
                 "vstack_block", "hstack_block", "zstack_block",
                 "text_block", "math_block",
                 "image_element", "listing_element",
                 "spacer_element", "divider_element":
                return type
                
            default:
                return childBlock(of: child)
            }
        }
        
        return nil
    }
}

// MARK: - Private Extensions

private extension Node {
    
    /// Returns child of node
    func descendant(for location: Int, in textView: TextViewController, subOnly: Bool = false) -> Node? {
        guard contains(location, in: textView) else {
            return nil
        }
        
        for i in 0..<childCount {
            guard let child = child(at: i) else {
                continue
            }
            
            if child.contains(location, in: textView) {
                return child.descendant(for: location, in: textView)
            }
        }
        
        return subOnly ? nil : self
    }
    
    /// Returns named child of node
    func namedDescendant(for location: Int, in textView: TextViewController, subOnly: Bool = false) -> Node? {
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
        
        return subOnly ? nil : self
    }
    
    /// Returns node containing location
    func contains(_ location: Int, in textView: TextViewController) -> Bool {
        let byteOffset = textView.byteOffsetForLocation(location)
        return byteRange.contains(byteOffset) || byteRange.upperBound == byteOffset
    }
}

private extension TextViewController {
    
    /// Returns byte offset for location in text
    func byteOffsetForLocation(_ location: Int) -> UInt32 {
        let index = String.Index(utf16Offset: location, in: text)
        let offset = text.utf16.distance(from: text.utf16.startIndex, to: index)
        let bytes = max(0, offset * 2 - 2)
        
        return UInt32(bytes)
    }
}

extension PageflowSuggestionDelegate {
    
    /// Debug tree
    private func debug(tree: Tree) {
        print(String(repeating: "=", count: 60))
        print("PARSED TREE")
        print(String(repeating: "=", count: 60))
        
        if let root = tree.rootNode {
            debug(node: root)
        }
        
        print(String(repeating: "=", count: 60))
    }
    
    /// Debug node
    private func debug(node: Node, indent: String = "") {
        let type = node.nodeType ?? "unknown"
        let range = node.byteRange
        
        print("\(indent)\(type) [\(range.lowerBound)-\(range.upperBound)]")
        
        for i in 0..<node.childCount {
            guard let child = node.child(at: i) else { continue }
            debug(node: child, indent: indent + "  ")
        }
    }
}
