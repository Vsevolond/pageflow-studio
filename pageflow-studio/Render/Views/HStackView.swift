//
//  HStackView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI
import Rearrange

struct HStackView<Content: View, Caption: View>: View {
    
    // MARK: - Internal Properties
    
    let content: Content
    let insets: EdgeInsets
    let spacing: CGFloat
    let alignment: VerticalAlignment
    let backgroundColor: NSColor
    let caption: Caption
    
    // MARK: - Initializers
    
    init(
        insets: EdgeInsets = EdgeInsets(
            top: 12,
            leading: 12,
            bottom: 12,
            trailing: 12
        ),
        spacing: CGFloat = 8,
        alignment: VerticalAlignment = .center,
        backgroundColor: NSColor = .clear,
        @ViewBuilder content: () -> Content,
        @ViewBuilder caption: () -> Caption
    ) {
        self.content = content()
        self.insets = insets
        self.spacing = spacing
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.caption = caption()
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: alignment, spacing: spacing) {
                content
            }
            .padding(
                EdgeInsets(
                    top: insets.top,
                    leading: insets.leading,
                    bottom: insets.bottom,
                    trailing: insets.trailing
                )
            )
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(backgroundColor))
            )
            .frame(alignment: .center)
            
            caption
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

// MARK: - Extensions

extension HStackView where Caption == EmptyView {
    
    // MARK: - Initializers
    
    init(
        insets: EdgeInsets = EdgeInsets(
            top: 12,
            leading: 12,
            bottom: 12,
            trailing: 12
        ),
        spacing: CGFloat = 8,
        alignment: VerticalAlignment = .center,
        backgroundColor: NSColor = .clear,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            insets: insets,
            spacing: spacing,
            alignment: alignment,
            backgroundColor: backgroundColor,
            content: content,
            caption: { EmptyView() }
        )
    }
}

// MARK: - Preview

#Preview {
    HStackView(
        insets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20),
        spacing: 12,
        alignment: .center,
        backgroundColor: .controlBackgroundColor
    ) {
        Text("Первый")
        Text("Второй")
        Text("Третий")
        
    } caption: {
        VStack(spacing: 4) {
            Text("Рис. 1:")
                .fontWeight(.bold)
            
            Text("Горизонтальный стек с элементами")
        }
    }
}

#Preview {
    HStackView(
        insets: EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32),
        spacing: 16,
        alignment: .top,
        backgroundColor: .selectedTextBackgroundColor.withAlphaComponent(0.3)
    ) {
        Image(systemName: "star.fill")
            .font(.largeTitle)
            .foregroundColor(.yellow)
        
        VStack(alignment: .leading) {
            Text("Заголовок")
                .font(.headline)
            
            Text("Описание элемента")
                .font(.subheadline)
        }
        
    } caption: {
        Text("Рис. 2: Выравнивание по верху")
    }
}

#Preview {
    HStackView(
        insets: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
        spacing: 8,
        alignment: .bottom,
        backgroundColor: .textBackgroundColor
    ) {
        Text("Элемент 1")
        Text("Элемент 2")
        Text("Элемент 3")
    }
}

#Preview {
    HStackView(
        insets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        spacing: 12,
        backgroundColor: .windowBackgroundColor
    ) {
        Text("Внешний")
        
        HStackView(
            insets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
            spacing: 4,
            alignment: .center,
            backgroundColor: .controlBackgroundColor
        ) {
            Text("Внутренний 1")
            Text("Внутренний 2")
        }
        
        HStackView(
            insets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
            spacing: 4,
            alignment: .center,
            backgroundColor: .selectedControlColor.withAlphaComponent(0.2)
        ) {
            Text("Внутренний A")
            Text("Внутренний B")
        }
        
    } caption: {
        HStack {
            Text("Рис. 3:")
                .fontWeight(.semibold)
            
            Text("Пример вложенных контейнеров")
        }
    }
}

#Preview {
    HStackView(
        insets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
        spacing: 0,
        backgroundColor: .clear
    ) {
        ListingView(
            text: """
            func example() {
                print("Hello")
            }
            """,
            language: "swift",
            style: "github",
            frame: CodeFrameType(value: .single, range: .notFound),
            numbers: true,
            fontSize: 12
        ) {
            EmptyView()
        }
        
        ListingView(
            text: """
            func world() {
                print("World")
            }
            """,
            language: "swift",
            style: "monokai",
            frame: CodeFrameType(value: .single, range: .notFound),
            numbers: true,
            fontSize: 12
        ) {
            EmptyView()
        }
        
    } caption: {
        Text("Листинг 1: Два кода рядом в HStackView")
    }
}
