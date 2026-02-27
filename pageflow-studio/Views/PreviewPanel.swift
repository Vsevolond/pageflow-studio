//
//  PreviewPanel.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 28.02.2026.
//

import SwiftUI

struct PreviewPanel: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Preview")
                    .font(.headline)
                
                Spacer()
                
                Text("\(viewModel.renderedPages.count) pages")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            Divider()
            
            if viewModel.renderedPages.isEmpty {
                ContentUnavailableView(
                    "No Preview",
                    systemImage: "eye.slash",
                    description: Text(viewModel.parseResult == nil
                        ? "Start typing to see preview"
                        : "Fix errors to see preview")
                )
                
            } else {
                VerticalTabView(pages: viewModel.renderedPages)
            }
        }
    }
}

struct VerticalTabView: View {
    let pages: [DefaultPageView]
    @State private var selectedIndex = 0
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, _ in
                        TabButton(
                            index: index,
                            isSelected: selectedIndex == index,
                            action: { selectedIndex = index }
                        )
                    }
                }
                .padding(8)
            }
            .frame(width: 120)
            .background(Color(NSColor.controlBackgroundColor))
            
            Divider()
            
            if pages.indices.contains(selectedIndex) {
                ScrollView {
                    PagePreviewWrapper(page: pages[selectedIndex])
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct TabButton: View {
    let index: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "doc.text")
                Text("Page \(index + 1)")
                    .lineLimit(1)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 1)
        )
    }
}

struct PagePreviewWrapper: View {
    let page: DefaultPageView
    
    var body: some View {
        page
            .shadow(radius: 5)
            .padding()
    }
}
