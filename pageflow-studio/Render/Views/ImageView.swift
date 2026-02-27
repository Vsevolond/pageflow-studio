//
//  ImageView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

struct ImageView<Content: View>: View {
    
    // MARK: - Internal Properties
    
    let image: NSImage
    let width: CGFloat?
    let height: CGFloat?
    let caption: Content
    
    // MARK: - Initializers
    
    init(
        image: NSImage,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        @ViewBuilder caption: () -> Content
    ) {
        self.image = image
        self.width = width
        self.height = height
        self.caption = caption()
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: 8) {
            imageBlock
            
            caption
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .fixedSize()
    }
    
    // MARK: - Nested Views
    
    @ViewBuilder
    private var imageBlock: some View {
        let size = calculateSize()
        
        Image(nsImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
    }
    
    // MARK: - Private Methods
    
    private func calculateSize() -> CGSize {
        let originalSize = image.size
        
        if let w = width, let h = height {
            return CGSize(width: w, height: h)
        }
        
        if let w = width {
            let ratio = w / originalSize.width
            return CGSize(width: w, height: originalSize.height * ratio)
        }
        
        if let h = height {
            let ratio = h / originalSize.height
            return CGSize(width: originalSize.width * ratio, height: h)
        }
        
        let maxDimension: CGFloat = 597
        
        if originalSize.width > maxDimension || originalSize.height > maxDimension {
            let ratio = min(
                maxDimension / originalSize.width,
                maxDimension / originalSize.height
            )
            
            return CGSize(
                width: originalSize.width * ratio,
                height: originalSize.height * ratio
            )
        }
        
        return originalSize
    }
}

// MARK: - Extensions

extension ImageView where Content == EmptyView {
    
    // MARK: - Initializers
    
    init(
        image: NSImage,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        self.init(
            image: image,
            width: width,
            height: height,
            caption: { EmptyView() }
        )
    }
}

// MARK: - Preview

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "photo",
            accessibilityDescription: nil
        )!,
        width: 200,
        height: nil
    ) {
        VStack(spacing: 4) {
            Text("Рис. 1:")
                .fontWeight(.bold)
            
            Text("Изображение с подписью")
        }
    }
    .padding()
}

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "star.fill",
            accessibilityDescription: nil
        )!,
        width: 150
    ) {
        Text("Рис. 2: Звезда фиксированной ширины")
    }
    .padding()
}

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "heart.fill",
            accessibilityDescription: nil
        )!,
        height: 100
    ) {
        Text("Рис. 3: Сердце фиксированной высоты")
    }
    .padding()
}

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "moon.fill",
            accessibilityDescription: nil
        )!,
        width: 120,
        height: 80
    ) {
        Text("Рис. 4: Луна с фиксированными размерами")
    }
    .padding()
}

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "sun.max.fill",
            accessibilityDescription: nil
        )!,
        width: 100
    )
    .padding()
}

#Preview {
    ImageView(
        image: NSImage(
            systemSymbolName: "cloud.fill",
            accessibilityDescription: nil
        )!
    ) {
        Text("Рис. 6: Облако в оригинальном размере")
    }
    .padding()
}
