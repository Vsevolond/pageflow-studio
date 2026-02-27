//
//  ListingView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI
import Highlighter
import Rearrange

struct ListingView<Content: View>: View {
    
    // MARK: - Internal Properties
    
    let text: String
    let language: String?
    let style: String?
    let frame: CodeFrameType?
    let numbers: Bool
    let fontSize: CGFloat
    let font: NSFont
    let caption: Content
    
    // MARK: - Private Properties
    
    @State private var attributedString: NSAttributedString?
    @State private var highlighter: CodeHighlighter?
    @State private var textHeight: CGFloat = 0
    
    // Минимальная высота для одной строки
    private let minHeight: CGFloat = 24
    
    // MARK: - Initializers
    
    init(
        text: String,
        language: String? = nil,
        style: String? = nil,
        frame: CodeFrameType? = nil,
        numbers: Bool = false,
        fontSize: CGFloat = 12,
        font: NSFont = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular),
        @ViewBuilder caption: () -> Content
    ) {
        self.text = text
        self.language = language
        self.style = style
        self.frame = frame
        self.numbers = numbers
        self.fontSize = fontSize
        self.font = font
        self.caption = caption()
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            codeBlock
            
            caption
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            setupHighlighter()
        }
        .onChange(of: text) {
            textHeight = 0
            updateHighlighting()
        }
        .onChange(of: language) {
            textHeight = 0
            updateHighlighting()
        }
        .onChange(of: style) {
            textHeight = 0
            updateHighlighting()
        }
    }
    
    // MARK: - Nested Views
    
    @ViewBuilder
    private var codeBlock: some View {
        ZStack(alignment: .topLeading) {
            frameBackground
            
            if let attrString = attributedString {
                TextViewWrapper(
                    attributedString: attrString,
                    font: font,
                    onHeightChange: { height in
                        if height > 0 {
                            self.textHeight = height
                        }
                    }
                )
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                
            } else {
                Text(text)
                    .font(Font(font))
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .frame(
            height: max(textHeight + 16, minHeight)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var frameBackground: some View {
        let isDark = highlighter?.theme?.isDark ?? false
        
        if let frame = frame {
            switch frame.value {
            case .lefline:
                Color.clear
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                    )
                    .overlay(
                        Rectangle()
                            .fill(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            .frame(width: 2),
                        alignment: .leading
                    )
                
            case .topline:
                Color.clear
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                    )
                    .overlay(
                        Rectangle()
                            .fill(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            .frame(height: 2),
                        alignment: .top
                    )
                
            case .bottomline:
                Color.clear
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                    )
                    .overlay(
                        Rectangle()
                            .fill(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            .frame(height: 2),
                        alignment: .bottom
                    )
                
            case .lines:
                Color.clear
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                    )
                    .overlay(
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                                .frame(height: 2)
                            
                            Spacer()
                            
                            Rectangle()
                                .fill(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                                .frame(height: 2)
                        }
                    )
                
            case .single:
                Color.clear
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(isDark ? Color.white.opacity(0.3) : Color.black.opacity(0.3), lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                            )
                    )
            }
            
        } else {
            Color.clear
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(isDark ? Color.black.opacity(0.3) : Color.gray.opacity(0.1))
                )
        }
    }
    
    // MARK: - Private Methods
    
    private func setupHighlighter() {
        highlighter = CodeHighlighter()
        updateHighlighting()
    }
    
    private func updateHighlighting() {
        guard let hl = highlighter else {
            attributedString = NSAttributedString(
                string: text,
                attributes: [
                    .font: font,
                    .foregroundColor: NSColor.textColor
                ]
            )
            
            return
        }
        
        attributedString = hl.highlight(
            text,
            language: language,
            style: style,
            font: font,
            lineNumbers: numbers
        )
    }
}

// MARK: - Code Highlighter

final class CodeHighlighter {
    
    // MARK: - Private Properties
    
    private let highlighter: Highlighter?
    
    // MARK: - Internal Properties
    
    var theme: Theme? {
        return highlighter?.theme
    }
    
    var availableThemes: [String] {
        return highlighter?.availableThemes() ?? []
    }
    
    var supportedLanguages: [String] {
        return highlighter?.supportedLanguages() ?? []
    }
    
    // MARK: - Initializers
    
    init?() {
        guard let hl = Highlighter() else { return nil }
        self.highlighter = hl
    }
    
    // MARK: - Internal Methods
    
    public func highlight(
        _ code: String,
        language: String?,
        style: String?,
        font: NSFont,
        lineNumbers: Bool
    ) -> NSAttributedString? {
        guard let hl = highlighter else { return nil }
        
        let themeName = style ?? "default"
        _ = hl.setTheme(themeName, withFont: font.fontName, ofSize: font.pointSize)
        
        var lineData: LineNumberData?
        
        if lineNumbers {
            lineData = LineNumberData(
                usingDarkTheme: hl.theme.isDark,
                lineBreak: "\n",
                fontSize: font.pointSize
            )
            lineData?.minWidth = 2
        }
        
        return hl.highlight(code, as: language, doFastRender: true, lineNumbering: lineData)
    }
}

// MARK: - Helper Views

struct TextViewWrapper: NSViewRepresentable {
    
    // MARK: - Internal Properties
    
    let attributedString: NSAttributedString
    let font: NSFont
    let onHeightChange: (CGFloat) -> Void
    
    // MARK: - Internal Methods
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .clear
        textView.textContainer?.lineFragmentPadding = 0
        textView.textContainerInset = NSSize(width: 0, height: 0)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width]
        
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        guard let textStorage = nsView.textStorage,
              let textContainer = nsView.textContainer,
              let layoutManager = nsView.layoutManager
        else {
            return
        }
        
        textStorage.setAttributedString(attributedString)
        layoutManager.ensureLayout(for: textContainer)
        
        DispatchQueue.main.async {
            let usedRect = layoutManager.usedRect(for: textContainer)
            
            let height = usedRect.height
            self.onHeightChange(height)
        }
    }
}

// MARK: - Extensions

extension ListingView where Content == EmptyView {
    
    // MARK: - Initializers
    
    init(
        text: String,
        language: String? = nil,
        style: String? = nil,
        frame: CodeFrameType? = nil,
        numbers: Bool = false,
        fontSize: CGFloat = 12,
        font: NSFont = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    ) {
        self.init(
            text: text,
            language: language,
            style: style,
            frame: frame,
            numbers: numbers,
            fontSize: fontSize,
            font: font,
            caption: { EmptyView() }
        )
    }
}

// MARK: - Preview

#Preview {
    ListingView(
        text: """
        func helloWorld() {
            print("Hello, World!")
            return 42
        }
        """,
        language: "swift",
        style: "github",
        frame: CodeFrameType(value: .lefline, range: .notFound),
        numbers: true,
        fontSize: 13,
        font: NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
    ) {
        Text("Листинг 1: Пример функции на Swift")
    }
    .padding()
}

#Preview {
    ListingView(
        text: """
        #include <stdio.h>
        
        int main() {
            printf("Hello, World!\\n");
            return 0;
        }
        """,
        language: "c",
        style: "monokai",
        frame: CodeFrameType(value: .single, range: .notFound),
        numbers: true,
        fontSize: 12
    ) {
        Text("Классическая программа на C")
    }
    .padding()
}

#Preview {
    ListingView(
        text: """
        SELECT * FROM users 
        WHERE age > 18 
        ORDER BY name;
        """,
        language: "sql",
        style: "atom-one-light",
        frame: CodeFrameType(value: .lines, range: .notFound),
        numbers: false
    )
    .padding()
}

#Preview {
    ListingView(
        text: """
        const greeting = "Hello";
        console.log(greeting);
        """,
        language: "javascript",
        style: "vs2015",
        frame: CodeFrameType(value: .lefline, range: .notFound),
        numbers: true
    )
    .padding()
}
