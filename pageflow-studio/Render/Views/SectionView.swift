//
//  SectionView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI
import Rearrange

struct SectionView<Content: View, Title: View>: View {
    
    // MARK: - Internal Properties
    
    let content: Content
    let title: Title
    
    // MARK: - Initializers
    
    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder title: () -> Title
    ) {
        self.content = content()
        self.title = title()
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            title
            
            VStack(alignment: .leading, spacing: 8) {
                content
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 30) {
                SectionView(
                    content: {
                        Text("Это содержимое секции.")
                        Text("Может содержать несколько абзацев.")
                        Text("Каждый абзац с новой строки.")
                    },
                    title: {
                        Text("1. Введение")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                )
                
                SectionView(
                    content: {
                        HStackView(
                            spacing: 16,
                            alignment: .center,
                            backgroundColor: .controlBackgroundColor
                        ) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("Контент в HStack")
                        }
                        
                        Text("Обычный текст после.")
                    },
                    title: {
                        HStack {
                            Text("2.")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Методология")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("(важно)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                )
                
                SectionView(
                    content: {
                        VStackView(
                            spacing: 8,
                            alignment: .leading,
                            backgroundColor: .textBackgroundColor
                        ) {
                            Text("• Первый результат")
                            Text("• Второй результат")
                            Text("• Третий результат")
                        }
                        
                        ListingView(
                            text: """
                            func results() {
                                return [1, 2, 3]
                            }
                            """,
                            language: "swift",
                            style: "github",
                            frame: CodeFrameType(value: .lefline, range: .notFound),
                            numbers: true,
                            fontSize: 11
                        ) {
                            EmptyView()
                        }
                    },
                    title: {
                        Text("3. Результаты")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        }
                )
                
                SectionView(
                    content: {
                        Text("Основной текст раздела.")
                        
                        SectionView(
                            content: {
                                Text("Детали подраздела.")
                                Text("Дополнительная информация.")
                            },
                            title: {
                                Text("3.1. Детали реализации")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                            }
                        )
                    },
                    title: {
                        Text("4. Обсуждение")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                )
                
                SectionView(
                    content: {
                        ImageView(
                            image: NSImage(systemSymbolName: "doc.text", accessibilityDescription: nil)!,
                            width: 100
                        ) {
                            Text("Рис. 1: Документ")
                        }
                        
                        Text("Описание изображения в тексте секции.")
                    },
                    title: {
                        Text("5. Иллюстрации")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                )
            }
            .padding()
        }
        .frame(width: 600, height: 900)
    }
}
