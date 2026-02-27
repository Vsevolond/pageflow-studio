//
//  ResourceSidebar.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 28.02.2026.
//

import SwiftUI

struct ResourceSidebar: View {
    @ObservedObject var viewModel: EditorViewModel
    @State private var selectedTab: ResourceTab = .images
    
    enum ResourceTab: String, CaseIterable {
        case images = "Images"
        case listings = "Listings"
        
        var icon: String {
            switch self {
            case .images: return "photo"
            case .listings: return "doc.text"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Menu {
                    Button(action: { viewModel.requestImageImport() }) {
                        Label("Add Image...", systemImage: "photo")
                    }
                    .keyboardShortcut("i", modifiers: .command)
                    
                    Button(action: { viewModel.requestListingAdd() }) {
                        Label("Add Listing...", systemImage: "doc.text")
                    }
                    .keyboardShortcut("l", modifiers: .command)
                } label: {
                    Image(systemName: "plus")
                }
                .menuStyle(.borderlessButton)
                .fixedSize()
                
                Spacer()
                
                Picker("", selection: $selectedTab) {
                    ForEach(ResourceTab.allCases, id: \.self) { tab in
                        Image(systemName: tab.icon)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .fixedSize()
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            Divider()
            
            Group {
                switch selectedTab {
                case .images:
                    ImageListView(viewModel: viewModel)
                case .listings:
                    ListingListView(viewModel: viewModel)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .sheet(isPresented: $viewModel.showingImageNameDialog) {
            ImageNameDialog(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.showingListingDialog) {
            ListingDialog(viewModel: viewModel)
        }
    }
}

struct ImageListView: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.images) { image in
                HStack {
                    Image(nsImage: image.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .cornerRadius(4)
                    
                    Text(image.name)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: { viewModel.removeImage(image) }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .overlay {
            if viewModel.images.isEmpty {
                ContentUnavailableView(
                    "No Images",
                    systemImage: "photo",
                    description: Text("Press ⌘I or click + to add")
                )
            }
        }
    }
}

struct ListingListView: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.listings) { listing in
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading) {
                        Text(listing.name)
                            .fontWeight(.medium)
                        Text("\(listing.content.count) chars")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: { viewModel.removeListing(listing) }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .overlay {
            if viewModel.listings.isEmpty {
                ContentUnavailableView(
                    "No Listings",
                    systemImage: "doc.text",
                    description: Text("Press ⌘L or click + to add")
                )
            }
        }
    }
}

struct ImageNameDialog: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Import Image")
                .font(.headline)
            
            HStack {
                if let url = viewModel.pendingImageURL,
                   let image = NSImage(contentsOf: url) {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading) {
                    Text("Image Name")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    TextField("name", text: $viewModel.pendingImageName)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                    
                    Text("Only a-z, A-Z, 0-9, _, - allowed")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Button("Cancel", role: .cancel) {
                    viewModel.cancelImageImport()
                }
                
                Button("Import") {
                    viewModel.confirmImageImport()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(!viewModel.isValidName(viewModel.pendingImageName) ||
                         viewModel.imageNameExists(viewModel.pendingImageName))
            }
        }
        .padding()
        .frame(width: 400)
    }
}

struct ListingDialog: View {
    @ObservedObject var viewModel: EditorViewModel
    @FocusState private var focusField: Field?
    
    enum Field {
        case name, content
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Add Listing")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Name (a-z, A-Z, 0-9, _, -)")
                    .font(.caption)
                
                TextField("listing_name", text: $viewModel.newListingName)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusField, equals: .name)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Content")
                    .font(.caption)
                
                TextEditor(text: $viewModel.newListingContent)
                    .font(.system(.body, design: .monospaced))
                    .frame(height: 200)
                    .border(Color.secondary.opacity(0.2), width: 1)
                    .focused($focusField, equals: .content)
            }
            
            if let error = viewModel.listingError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            HStack {
                Button("Cancel", role: .cancel) {
                    viewModel.cancelListingAdd()
                }
                
                Button("Add") {
                    viewModel.confirmListingAdd()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
        .frame(width: 400)
        .onAppear {
            focusField = .name
        }
    }
}
