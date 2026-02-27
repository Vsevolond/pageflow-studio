//
//  CodeEditorPanel.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 28.02.2026.
//

import SwiftUI
import PageflowLanguage
import PageflowSourceEditor
import CodeEditTextView

struct CodeEditorPanel: View {
    @ObservedObject var viewModel: EditorViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            SourceEditor(
                $viewModel.text,
                language: .pageflow,
                configuration: SourceEditorConfiguration(
                    appearance: .init(
                        theme: viewModel.theme,
                        font: viewModel.font,
                        wrapLines: true
                    ),
                    behavior: .init(indentOption: viewModel.indentOption)
                ),
                state: $viewModel.editorState,
                coordinators: [viewModel.coordinatorInstance],
                completionDelegate: viewModel.suggestionsInstance
            )
            .onAppear {
                updateTheme()
            }
            .onChange(of: colorScheme) {
                updateTheme()
            }
            
            if let result = viewModel.parseResult,
               case .failure(let error) = result {
                ErrorPanel(error: error, text: viewModel.text)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    private func updateTheme() {
        switch colorScheme {
        case .light: viewModel.theme = .light
        case .dark: viewModel.theme = .dark
        @unknown default: viewModel.theme = .light
        }
    }
}

struct ErrorPanel: View {
    let error: PageflowParseError
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                
                Text("Parse Error")
                    .font(.headline)
                
                Spacer()
            }
            
            Text(errorDescription)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.red.opacity(0.3)),
            alignment: .top
        )
    }
    
    private var errorDescription: String {
        let (start, end) = errorRange
        return "\(errorMessage) at \(start) - \(end)"
    }
    
    private var errorMessage: String {
        switch error {
        case .syntax: return "Syntax error"
        case .unknown(let file, _): return "Unknown file '\(file)'"
        case .invalidExpression: return "Invalid expression"
        case .invalidOperation(let op, _): return "Invalid operation '\(op)'"
        }
    }
    
    private var errorRange: (String, String) {
        let range: NSRange
        switch error {
        case .syntax(let r): range = r
        case .unknown(_, let r): range = r
        case .invalidExpression(let r): range = r
        case .invalidOperation(_, let r): range = r
        }
        
        let start = position(from: range.location)
        let end = position(from: range.location + range.length)
        return (start, end)
    }
    
    private func position(from offset: Int) -> String {
        let nsString = text as NSString
        let line = nsString.lineRange(for: NSRange(location: offset, length: 0))
        let lineNumber = nsString.substring(to: offset).components(separatedBy: .newlines).count
        let column = offset - line.location + 1
        return "(\(lineNumber), \(column))"
    }
}
