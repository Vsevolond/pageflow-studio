//
//  TextMathView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI
import SwiftMath
import Rearrange

struct TextMathView: NSViewRepresentable {
    
    // MARK: - Type Entities
    
    enum Fragment {
        case text(String)
        case math(String)
    }
    
    // MARK: - Internal Properties
    
    let fragments: [Fragment]
    
    let textAlignment: NSTextAlignment
    let lineSpacing: CGFloat?
    let insets: NSEdgeInsets
    let underline: (style: NSUnderlineStyle, color: NSColor)?
    let strikethrough: (style: NSUnderlineStyle, color: NSColor)?
    let fontSize: CGFloat
    let font: NSFont
    let foregroundColor: NSColor
    
    // MARK: - Internal Methods
    
    func makeNSView(context: Context) -> TextMathContainer {
        return TextMathContainer(
            textAlignment: textAlignment,
            foregroundColor: foregroundColor
        )
    }
    
    func updateNSView(_ container: TextMathContainer, context: Context) {
        let string = attributedString()
        container.textField.attributedStringValue = string
        
        DispatchQueue.main.async {
            container.textField.preferredMaxLayoutWidth = container.frame.width
            container.invalidateIntrinsicContentSize()
        }
    }
    
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        nsView: TextMathContainer,
        context: Context
    ) -> CGSize? {
        let string = attributedString()
        let width = proposal.width ?? .greatestFiniteMagnitude
        let height = proposal.height ?? .greatestFiniteMagnitude
        
        let size = string.boundingRect(
            with: CGSize(width: width, height: height),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).size
           
        return CGSize(
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }
    
    // MARK: - Private Methods
    
    private func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()
        
        for fragment in fragments {
            switch fragment {
            case .text(let string):
                let style = NSMutableParagraphStyle()
                style.alignment = textAlignment
                
                if let lineSpacing {
                    style.lineSpacing = lineSpacing
                }
                
                var attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: foregroundColor,
                    .paragraphStyle: style
                ]
                
                if let underline {
                    attributes[.underlineStyle] = underline.style.rawValue
                    attributes[.underlineColor] = underline.color
                }
                
                if let strikethrough {
                    attributes[.strikethroughStyle] = strikethrough.style.rawValue
                    attributes[.strikethroughColor] = strikethrough.color
                }
                
                let string = NSAttributedString(
                    string: string,
                    attributes: attributes
                )
                result.append(string)
                
            case .math(let string):
                let string = math(text: string)
                result.append(string)
            }
        }
        
        return result
    }
    
    private func math(text: String) -> NSAttributedString {
        let window = NSWindow(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: 597,
                height: 845
            ),
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )
        window.isReleasedWhenClosed = false
        
        defer { window.close() }
        
        let mathLabel = MTMathUILabel()
        mathLabel.latex = text
        mathLabel.font = MTFontManager().latinModernFont(withSize: fontSize)
        mathLabel.fontSize = fontSize
        mathLabel.textColor = foregroundColor
        mathLabel.preferredMaxLayoutWidth = 597
        mathLabel.textAlignment = MTTextAlignment(from: textAlignment)
        mathLabel.contentInsets = insets
        
        if let contentView = window.contentView {
            contentView.addSubview(mathLabel)
            
            mathLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mathLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                mathLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
            
            contentView.layoutSubtreeIfNeeded()
        }
        
        let size = mathLabel.fittingSize
        
        guard size.width > 0, size.height > 0 else {
            return NSAttributedString(string: "[\(text)]")
        }
        
        mathLabel.frame = NSRect(origin: .zero, size: size)
        
        guard let rep = mathLabel.bitmapImageRepForCachingDisplay(in: mathLabel.bounds) else {
            return NSAttributedString(string: "[\(text)]")
        }
        
        mathLabel.cacheDisplay(in: mathLabel.bounds, to: rep)
        
        guard let cgImage = rep.cgImage else {
            return NSAttributedString(string: "[\(text)]")
        }
        
        let image = NSImage(cgImage: cgImage, size: size)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let yOffset = font.descender - (size.height - font.ascender)
        
        attachment.bounds = CGRect(
            x: 0,
            y: yOffset,
            width: size.width,
            height: size.height
        )
        
        return NSAttributedString(attachment: attachment)
    }
}

// MARK: - Text Math Container

class TextMathContainer: NSView {
    
    // MARK: - Internal Properties
    
    let textField: NSTextField
    
    // MARK: - Initializers
    
    init(
        textAlignment: NSTextAlignment,
        foregroundColor: NSColor
    ) {
        textField = NSTextField(wrappingLabelWithString: "")
        textField.isEditable = false
        textField.isSelectable = false
        textField.alignment = textAlignment
        textField.textColor = foregroundColor
        textField.lineBreakMode = .byWordWrapping
        textField.maximumNumberOfLines = 0
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        
        super.init(frame: .zero)
        
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extensions

private extension MTTextAlignment {
    
    init(from alignment: NSTextAlignment) {
        switch alignment {
        case .left:
            self = .left
            
        case .center:
            self = .center
            
        case .right:
            self = .right
            
        default:
            self = .left
        }
    }
}

// MARK: - Preview

#Preview {
    TextMathView(
        fragments: [
            .text("Lorem ipsum text "),
            .math("\\alpha + \\beta = \\gamma"),
            .text(" Some text text some text "),
            .math("z = f(x, y) * 5")
        ],
        textAlignment: .left,
        lineSpacing: nil,
        insets: .zero,
        underline: nil,
        strikethrough: nil,
        fontSize: 12,
        font: .latex(size: 12, style: .medium),
        foregroundColor: .black
    )
    .background(.yellow)
    .frame(width: 200)
    .padding()
}
