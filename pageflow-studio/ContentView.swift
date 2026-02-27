//
//  ContentView.swift
//  pageflow-studio
//
//  Created by Всеволод Донченко on 11.11.2025.
//

//import SwiftUI
//import PageflowLanguage
//import PageflowSourceEditor
//import CodeEditTextView

//struct ContentView: View {
//    @State private var text = ""
//    @State private var editorState = SourceEditorState()
//    
//    @State var font = NSFont.monospacedSystemFont(ofSize: 16, weight: .regular)
//    @State var indentOption = IndentOption.tab
//    
//    @State private var theme = EditorTheme.light
//    
//    @Environment(\.colorScheme) private var colorScheme
//    
//    @StateObject private var model: ContentViewModel
//    @StateObject private var suggestions: PageflowSuggestionDelegate
//    @StateObject private var coordinator: PageflowParseCoordinator
//    
//    init() {
//        let model = ContentViewModel()
//        let suggestions = PageflowSuggestionDelegate(provider: model)
//        let coordinator = PageflowParseCoordinator(provider: model)
//        
//        self._model = StateObject(wrappedValue: model)
//        self._suggestions = StateObject(wrappedValue: suggestions)
//        self._coordinator = StateObject(wrappedValue: coordinator)
//    }
//    
//    var body: some View {
//        SourceEditor(
//            $text,
//            language: .pageflow,
//            configuration: SourceEditorConfiguration(
//                appearance: .init(
//                    theme: theme,
//                    font: font,
//                    wrapLines: true
//                ),
//                behavior: .init(indentOption: indentOption)
//            ),
//            state: $editorState,
//            coordinators: [coordinator],
//            completionDelegate: suggestions
//        )
//        .onAppear {
//            switch colorScheme {
//            case .light: theme = .light
//            case .dark: theme = .dark
//            @unknown default: theme = .light
//            }
//        }
//        .onChange(of: coordinator.result) {
//            print(coordinator.result)
//        }
//    }
//}

import SwiftUI
import PageflowLanguage
import PageflowSourceEditor
import CodeEditTextView

struct ContentView: View {
    @StateObject private var viewModel = EditorViewModel()
    
    var body: some View {
        NavigationSplitView {
            ResourceSidebar(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 300)
        } content: {
            CodeEditorPanel(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 400, ideal: 600, max: .infinity)
        } detail: {
            PreviewPanel(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 400, ideal: 600, max: 800)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ContentView()
}
