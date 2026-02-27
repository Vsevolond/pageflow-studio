//
//  ZStackView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI
import Rearrange

struct ZStackView<Content: View, Caption: View>: View {
    
    // MARK: - Internal Properties
    
    let content: Content
    let insets: EdgeInsets
    let spacing: CGFloat
    let alignment: Alignment
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
        alignment: Alignment = .center,
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
            ZStack(alignment: alignment) {
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

extension ZStackView where Caption == EmptyView {
    
    // MARK: - Initializers
    
    init(
        insets: EdgeInsets = EdgeInsets(
            top: 12,
            leading: 12,
            bottom: 12,
            trailing: 12
        ),
        spacing: CGFloat = 8,
        alignment: Alignment = .center,
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
    ZStackView(
        insets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20),
        spacing: 0,
        alignment: .center,
        backgroundColor: .controlBackgroundColor
    ) {
        Circle()
            .fill(Color.blue.opacity(0.3))
            .frame(width: 100, height: 100)
        
        Text("Центр")
            .font(.headline)
        
    } caption: {
        VStack(spacing: 4) {
            Text("Рис. 1:")
                .fontWeight(.bold)
            
            Text("Наложенные элементы по центру")
        }
    }
}

#Preview {
    ZStackView(
        insets: EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32),
        spacing: 0,
        alignment: .topLeading,
        backgroundColor: .selectedTextBackgroundColor.withAlphaComponent(0.3)
    ) {
        Rectangle()
            .fill(Color.green.opacity(0.2))
            .frame(width: 200, height: 150)
        
        Text("Верхний левый угол")
            .font(.caption)
            .padding(4)
            .background(Color.white.opacity(0.8))
        
    } caption: {
        Text("Рис. 2: Выравнивание в topLeading")
    }
}

#Preview {
    ZStackView(
        insets: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
        spacing: 0,
        alignment: .bottomTrailing,
        backgroundColor: .textBackgroundColor
    ) {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.orange.opacity(0.3))
            .frame(width: 180, height: 120)
        
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .font(.title)
    }
}

#Preview {
    ZStackView(
        insets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        spacing: 0,
        alignment: .center,
        backgroundColor: .windowBackgroundColor
    ) {
        Text("Фон")
            .font(.largeTitle)
            .foregroundColor(.gray.opacity(0.3))
        
        VStackView(
            insets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
            spacing: 4,
            alignment: .leading,
            backgroundColor: .controlBackgroundColor
        ) {
            Text("VStack поверх")
            Text("текста")
        }
        
        HStackView(
            insets: EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4),
            spacing: 4,
            alignment: .center,
            backgroundColor: .red.withAlphaComponent(0.2)
        ) {
            Text("HStack")
            Text("тоже")
        }
        .offset(x: 50, y: 30)
        
    } caption: {
        HStack {
            Text("Рис. 3:")
                .fontWeight(.semibold)
            
            Text("Вложенные стеки в ZStack")
        }
    }
}

#Preview {
    ZStackView(
        insets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
        spacing: 0,
        alignment: .center,
        backgroundColor: .clear
    ) {
        ListingView(
            text: """
            // Фоновый код
            func background() {}
            """,
            language: "swift",
            style: "vs2015",
            frame: CodeFrameType(value: .single, range: .notFound),
            numbers: false,
            fontSize: 10
        ) {
            EmptyView()
        }
        .opacity(0.3)
        
        Text("Поверх кода")
            .font(.title)
            .padding()
            .background(Color.white.opacity(0.9))
        
    } caption: {
        Text("Листинг 1: ZStack с полупрозрачным фоном")
    }
}
