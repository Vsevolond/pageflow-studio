//
//  Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import AppKit
import SwiftUI

final class Render {
    
    static let shared = Render()
    
    private init() {}
    
    func render(
        document: Document,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> [DefaultPageView] {
        let first = DefaultPageView.Parameters()
        var parameters = [first]
        
        for element in document.elements {
            render(
                element: element,
                parameters: &parameters,
                images: images,
                listings: listings
            )
        }
        
        let views = parameters.map { DefaultPageView(parameters: $0) }
        return views
    }
    
    func render(
        element: Element,
        parameters: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        switch element {
        case .newPage(let defaultNewPageBlock):
            render(
                block: defaultNewPageBlock,
                parameters: &parameters,
                images: images,
                listings: listings
            )
            
        case .section(let sectionBlock):
            render(
                block: sectionBlock,
                parameters: &parameters,
                images: images,
                listings: listings
            )
            
        case .content(let baseContent):
            guard let current = parameters.last else { return }
            
            let content = render(
                content: baseContent,
                context: .vertical,
                images: images,
                listings: listings
            )
            current.add { AnyView(content) }
        }
    }
    
    func render(
        block: DefaultNewPageBlock,
        parameters: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in block.content {
            switch content {
            case .section(let sectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let last = parameters.last else {
                        return
                    }
                    
                    let new = DefaultPageView.Parameters(insets: last.insets)
                    new.add(contentsOf: contents)
                    
                    parameters.append(new)
                    contents = []
                }
                
                render(
                    block: sectionBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .content(let baseContent):
                if isEnded {
                    guard let current = parameters.last else { return }
                    
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    current.add { AnyView(content) }
                    
                } else {
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    contents.append(AnyView(content))
                }
            }
        }
        
        if !isEnded && !contents.isEmpty {
            guard let last = parameters.last else {
                return
            }
            
            let new = DefaultPageView.Parameters(insets: last.insets)
            new.add(contentsOf: contents)
            
            parameters.append(new)
        }
    }
    
    func render(
        block: SectionNewPageBlock,
        parameters: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in block.content {
            switch content {
            case .subSection(let subSectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let last = parameters.last else {
                        return
                    }
                    
                    let new = DefaultPageView.Parameters(insets: last.insets)
                    new.add(contentsOf: contents)
                    
                    parameters.append(new)
                    contents = []
                }
                
                render(
                    block: subSectionBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .content(let baseContent):
                if isEnded {
                    guard let current = parameters.last else { return }
                    
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    current.add { AnyView(content) }
                    
                } else {
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    contents.append(AnyView(content))
                }
            }
        }
        
        if !isEnded && !contents.isEmpty {
            guard let last = parameters.last else {
                return
            }
            
            let new = DefaultPageView.Parameters(insets: last.insets)
            new.add(contentsOf: contents)
            
            parameters.append(new)
        }
    }
    
    func render(
        block: SectionBlock,
        parameters: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in block.content {
            switch content {
            case .newPage(let sectionNewPageBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parameters.last else { return }
                    
                    let view = sectionView(title: block.title, contents: contents)
                    current.add { AnyView(view) }
                    
                    contents = []
                }
                
                render(
                    block: sectionNewPageBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .subSection(let subSectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parameters.last else { return }
                    
                    let view = sectionView(title: block.title, contents: contents)
                    current.add { AnyView(view) }
                    
                    contents = []
                }
                
                render(
                    block: subSectionBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .content(let baseContent):
                if isEnded {
                    guard let current = parameters.last else { return }
                    
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    current.add { AnyView(content) }
                    
                } else {
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    contents.append(AnyView(content))
                }
            }
        }
        
        if !isEnded && !contents.isEmpty {
            guard let current = parameters.last else { return }
            
            let view = sectionView(title: block.title, contents: contents)
            current.add { AnyView(view) }
        }
    }
    
    func render(
        block: SubSectionBlock,
        parameters: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in block.content {
            switch content {
            case .newPage(let sectionNewPageBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parameters.last else { return }
                    
                    let view = subSectionView(title: block.title, contents: contents)
                    current.add { AnyView(view) }
                    
                    contents = []
                }
                
                render(
                    block: sectionNewPageBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .subSection(let subSectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parameters.last else { return }
                    
                    let view = subSectionView(title: block.title, contents: contents)
                    current.add { AnyView(view) }
                    
                    contents = []
                }
                
                render(
                    block: subSectionBlock,
                    parameters: &parameters,
                    images: images,
                    listings: listings
                )
                
            case .content(let baseContent):
                if isEnded {
                    guard let current = parameters.last else { return }
                    
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    current.add { AnyView(content) }
                    
                } else {
                    let content = render(
                        content: baseContent,
                        context: .vertical,
                        images: images,
                        listings: listings
                    )
                    contents.append(AnyView(content))
                }
            }
        }
        
        if !isEnded && !contents.isEmpty {
            guard let current = parameters.last else { return }
            
            let view = subSectionView(title: block.title, contents: contents)
            current.add { AnyView(view) }
        }
    }
    
    @ViewBuilder
    func render(block: TextBlock) -> some View {
        render(
            content: block.content,
            with: block.parameters
        )
    }
    
    @ViewBuilder
    func render(block: MathBlock) -> some View {
        render(
            content: block.content,
            with: block.parameters
        )
    }
    
    @ViewBuilder
    func render(
        content: BaseContent,
        context: Axis,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        switch content {
        case .vstack(let vStackBlock):
            render(block: vStackBlock, images: images, listings: listings)
            
        case .hstack(let hStackBlock):
            render(block: hStackBlock, images: images, listings: listings)
            
        case .zstack(let zStackBlock):
            render(block: zStackBlock, context: context, images: images, listings: listings)
            
        case .text(let textBlock):
            render(block: textBlock)
            
        case .math(let mathBlock):
            render(block: mathBlock)
            
        case .image(let imageElement):
            render(element: imageElement, images: images)
            
        case .spacer(let spacerElement):
            render(element: spacerElement)
            
        case .divider(let dividerElement):
            render(element: dividerElement, axis: context)
            
        case .listing(let listingElement):
            render(element: listingElement, listings: listings)
            
        case .rawText(let textContent):
            render(content: textContent)
            
        case .rawMath(let mathContent):
            render(content: mathContent)
        }
    }
    
    @ViewBuilder
    func render(
        content: TextContent,
        with parameters: TextBlock.Parameters = .init()
    ) -> some View {
        let view = TextMathView(
            fragments: content.fragments.rawValue,
            textAlignment: parameters.textAlignment,
            lineSpacing: parameters.lineSpacing,
            insets: .zero,
            underline: parameters.underline,
            strikethrough: parameters.strikethrough,
            fontSize: parameters.fontSize,
            font: parameters.font,
            foregroundColor: parameters.foregroundColor
        )
        
        textContentView(
            for: view,
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment,
            padding: parameters.padding,
            offset: parameters.offset
        )
    }
    
    @ViewBuilder
    func render(
        content: MathContent,
        with parameters: MathBlock.Parameters = .init()
    ) -> some View {
        let view = TextMathView(
            fragments: content.fragments.rawValue,
            textAlignment: parameters.textAlignment,
            lineSpacing: parameters.lineSpacing,
            insets: parameters.insets,
            underline: nil,
            strikethrough: nil,
            fontSize: parameters.fontSize,
            font: parameters.font,
            foregroundColor: parameters.foregroundColor
        )
        
        mathContentView(
            for: view,
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment,
            padding: parameters.padding,
            offset: parameters.offset
        )
    }
}

extension Render {
    
    @ViewBuilder
    private func sectionView(
        title: TextContent,
        contents: [AnyView]
    ) -> some View {
        SectionView {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } title: {
            let parameters = TextBlock.Parameters(
                fontSize: 17,
                font: NSFont.latex(size: 17, style: .bold)
            )
            
            render(content: title, with: parameters)
        }
    }
    
    @ViewBuilder
    private func subSectionView(
        title: TextContent,
        contents: [AnyView]
    ) -> some View {
        SectionView {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } title: {
            let parameters = TextBlock.Parameters(
                fontSize: 14,
                font: NSFont.latex(size: 14, style: .bold)
            )
            
            render(content: title, with: parameters)
        }
    }
    
    @ViewBuilder
    func render(
        block: VStackBlock,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        let parameters = block.parameters
        let content = block.content
        
        let contents = content.map {
            AnyView(
                render(
                    content: $0,
                    context: .vertical,
                    images: images,
                    listings: listings
                )
            )
        }
        
        VStackView(
            insets: parameters.insets,
            spacing: parameters.spacing,
            alignment: parameters.stackAlignment,
            backgroundColor: parameters.backgroundColor
        ) {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } caption: {
            if let caption = parameters.caption {
                TextMathView(
                    fragments: caption.fragments.rawValue,
                    textAlignment: .center,
                    lineSpacing: nil,
                    insets: .zero,
                    underline: nil,
                    strikethrough: nil,
                    fontSize: 10,
                    font: NSFont.latex(size: 10),
                    foregroundColor: .darkGray
                )
            }
        }
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
    
    @ViewBuilder
    func render(
        block: HStackBlock,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        let parameters = block.parameters
        let content = block.content
        
        let contents = content.map {
            AnyView(
                render(
                    content: $0,
                    context: .horizontal,
                    images: images,
                    listings: listings
                )
            )
        }
        
        HStackView(
            insets: parameters.insets,
            spacing: parameters.spacing,
            alignment: parameters.stackAlignment,
            backgroundColor: parameters.backgroundColor
        ) {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } caption: {
            if let caption = parameters.caption {
                TextMathView(
                    fragments: caption.fragments.rawValue,
                    textAlignment: .center,
                    lineSpacing: nil,
                    insets: .zero,
                    underline: nil,
                    strikethrough: nil,
                    fontSize: 10,
                    font: NSFont.latex(size: 10),
                    foregroundColor: .darkGray
                )
            }
        }
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
    
    @ViewBuilder
    func render(
        block: ZStackBlock,
        context: Axis,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        let parameters = block.parameters
        let content = block.content
        
        let contents = content.map {
            AnyView(
                render(
                    content: $0,
                    context: context,
                    images: images,
                    listings: listings
                )
            )
        }
        
        ZStackView(
            insets: parameters.insets,
            spacing: parameters.spacing,
            alignment: parameters.stackAlignment,
            backgroundColor: parameters.backgroundColor
        ) {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } caption: {
            if let caption = parameters.caption {
                TextMathView(
                    fragments: caption.fragments.rawValue,
                    textAlignment: .center,
                    lineSpacing: nil,
                    insets: .zero,
                    underline: nil,
                    strikethrough: nil,
                    fontSize: 10,
                    font: NSFont.latex(size: 10),
                    foregroundColor: .darkGray
                )
            }
        }
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
    
    @ViewBuilder
    func render(
        element: DividerElement,
        axis: Axis
    ) -> some View {
        let parameters = element.parameters
        
        divider(
            thickness: element.thickness?.points,
            tint: parameters.foregroundColor,
            axis: axis
        )
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
    
    @ViewBuilder
    func render(element: SpacerElement) -> some View {
        Spacer(minLength: element.value?.points)
    }
    
    @ViewBuilder
    func render(
        element: ImageElement,
        images: [(name: String, image: NSImage)]
    ) -> some View {
        if let (_, image) = images.first(where: { $0.name == element.name.value }) {
            let parameters = element.parameters
            
            let view = ImageView(
                image: image,
                width: parameters.width,
                height: parameters.height
            ) {
                if let caption = parameters.caption {
                    TextMathView(
                        fragments: caption.fragments.rawValue,
                        textAlignment: .center,
                        lineSpacing: nil,
                        insets: .zero,
                        underline: nil,
                        strikethrough: nil,
                        fontSize: 10,
                        font: NSFont.latex(size: 10),
                        foregroundColor: .darkGray
                    )
                }
            }
            
            imageElementView(
                for: view,
                padding: parameters.padding,
                offset: parameters.offset,
                alignment: parameters.alignment
            )
        }
    }
    
    @ViewBuilder
    func render(
        element: ListingElement,
        listings: [(name: String, listing: String)]
    ) -> some View {
        if let (_, listing) = listings.first(where: { $0.name == element.name.value }) {
            let parameters = element.parameters
            
            ListingView(
                text: listing,
                language: parameters.language,
                style: parameters.style,
                frame: parameters.frame,
                numbers: parameters.numbers,
                fontSize: parameters.fontSize,
                font: parameters.font
            ) {
                if let caption = parameters.caption {
                    TextMathView(
                        fragments: caption.fragments.rawValue,
                        textAlignment: .center,
                        lineSpacing: nil,
                        insets: .zero,
                        underline: nil,
                        strikethrough: nil,
                        fontSize: 10,
                        font: NSFont.latex(size: 10),
                        foregroundColor: .darkGray
                    )
                }
            }
        }
    }
}

extension Render {
    
    @ViewBuilder
    private func textContentView(
        for view: TextMathView,
        width: CGFloat?,
        height: CGFloat?,
        alignment: Alignment,
        padding: EdgeInsets,
        offset: CGSize
    ) -> some View {
        view
            .frame(width: width, height: height, alignment: alignment)
            .padding(padding)
            .offset(offset)
    }
    
    @ViewBuilder
    private func mathContentView(
        for view: TextMathView,
        width: CGFloat?,
        height: CGFloat?,
        alignment: Alignment,
        padding: EdgeInsets,
        offset: CGSize
    ) -> some View {
        view
            .frame(width: width, height: height, alignment: alignment)
            .padding(padding)
            .offset(offset)
    }
    
    @ViewBuilder
    private func divider(
        thickness: CGFloat?,
        tint nsColor: NSColor?,
        axis: Axis
    ) -> some View {
        if let nsColor {
            let color = Color(nsColor: nsColor)
            
            switch axis {
            case .horizontal:
                Divider()
                    .frame(height: thickness)
                    .overlay(color)
                
            case .vertical:
                Divider()
                    .frame(width: thickness)
                    .overlay(color)
            }
            
        } else {
            switch axis {
            case .horizontal:
                Divider()
                    .frame(height: thickness)
                
            case .vertical:
                Divider()
                    .frame(width: thickness)
            }
        }
    }
    
    @ViewBuilder
    private func imageElementView(
        for view: ImageView<TextMathView?>,
        padding: EdgeInsets,
        offset: CGSize,
        alignment: Alignment
    ) -> some View {
        view
            .frame(alignment: alignment)
            .padding(padding)
            .offset(offset)
    }
}
