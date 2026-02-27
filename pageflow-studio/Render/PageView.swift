//
//  PageView.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

typealias DefaultPageView = PageView<AnyView, AnyView, AnyView>

struct PageView<Header: View, Footer: View, Content: View>: View {
    
    // MARK: - Parameters
    
    let parameters: Parameters
    
    // MARK: - Private Properties
    
    private var header: Header? { parameters.header }
    private var footer: Footer? { parameters.footer }
    private var insets: PageInsets { parameters.insets }
    private var contents: [Content] { parameters.contents }
    
    private var contentInsets: EdgeInsets {
        EdgeInsets(
            top: header == nil ? (insets.top ?? 0) : 25,
            leading: insets.leading ?? 0,
            bottom: footer == nil ? (insets.bottom ?? 0) : 25,
            trailing: insets.trailing ?? 0
        )
    }
    
    // MARK: - Initializers
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: .zero) {
            if let headerView = header {
                headerView
                    .padding(.top, insets.top ?? 72)
                    .padding(.leading, insets.leading ?? 0)
                    .padding(.trailing, insets.trailing ?? 0)
            }
            
            content
                .padding(.top, contentInsets.top)
                .padding(.bottom, contentInsets.bottom)
                .padding(.leading, contentInsets.leading)
                .padding(.trailing, contentInsets.trailing)
            
            if let footerView = footer {
                footerView
                    .padding(.bottom, insets.bottom ?? 72)
                    .padding(.leading, insets.leading ?? 0)
                    .padding(.trailing, insets.trailing ?? 0)
            }
        }
        .frame(width: 597, height: 845)
    }
    
    // MARK: - Nested Views
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<contents.count, id: \.self) { index in
                contents[index]
           }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .leading
        )
    }
}

// MARK: - Extensions

extension PageView {
    
    // MARK: - Type Entities
    
    final class Parameters {
        
        let header: Header?
        let footer: Footer?
        let insets: PageInsets
        
        var contents: [Content]
        
        init(
            header: Header? = nil,
            footer: Footer? = nil,
            insets: PageInsets = .none,
            contents: [Content] = []
        ) {
            self.header = header
            self.footer = footer
            self.insets = insets
            self.contents = contents
        }
        
        func add(@ViewBuilder content: () -> Content) {
            let content = content()
            contents.append(content)
        }
        
        func add(contentsOf: [Content]) {
            contents.append(contentsOf: contentsOf)
        }
    }
}
