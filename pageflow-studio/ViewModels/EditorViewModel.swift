//
//  EditorViewModel.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 28.02.2026.
//

import SwiftUI
import Combine
import PageflowLanguage
import PageflowSourceEditor
internal import UniformTypeIdentifiers

final class EditorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var text = ""
    @Published var editorState = SourceEditorState()
    @Published var font = NSFont.monospacedSystemFont(ofSize: 16, weight: .regular)
    @Published var indentOption = IndentOption.tab
    @Published var theme = EditorTheme.light
    
    private let model: ContentViewModel
    private let suggestions: PageflowSuggestionDelegate
    private let coordinator: PageflowParseCoordinator
    
    @Published var images: [ImageResource] = []
    @Published var listings: [ListingResource] = []
    @Published var renderedPages: [DefaultPageView] = []
    @Published var showingImageImportDialog = false
    @Published var showingListingDialog = false
    @Published var showingImageNameDialog = false
    
    @Published var pendingImageURL: URL?
    @Published var pendingImageName = ""
    @Published var newListingName = ""
    @Published var newListingContent = ""
    @Published var listingError: String?
    
    private let validNameRegex = /^[a-zA-Z0-9_\-]+$/
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init() {
        let model = ContentViewModel()
        let suggestions = PageflowSuggestionDelegate(provider: model)
        let coordinator = PageflowParseCoordinator(provider: model)
        
        self.model = model
        self.suggestions = suggestions
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        coordinator.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.handleParseResult(result)
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($images, $listings)
            .sink { [weak self] images, listings in
                self?.updateModelResources(images: images, listings: listings)
            }
            .store(in: &cancellables)
    }
    
    private func updateModelResources(images: [ImageResource], listings: [ListingResource]) {
        model.images = Set(images.map { $0.name })
        model.listings = Set(listings.map { $0.name })
    }
    
    private func handleParseResult(_ result: Result<Document, PageflowParseError>) {
        switch result {
        case .success(let document):
            renderDocument(document)
        case .failure:
            renderedPages = []
        }
    }
    
    private func renderDocument(_ document: Document) {
        let imageData = images.map { ($0.name, $0.image) }
        let listingData = listings.map { ($0.name, $0.content) }
        
        renderedPages = Render.shared.render(document: document, images: imageData, listings: listingData)
    }
    
    // MARK: - Internal Methods
    
    func requestImageImport() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.image, .png, .jpeg, .tiff, .gif, .bmp]
        openPanel.message = "Select an image to import"
        
        openPanel.begin { [weak self] result in
            guard let self = self, result == .OK, let url = openPanel.url else { return }
            
            let fileName = url.deletingPathExtension().lastPathComponent
            let sanitizedName = self.sanitizeName(fileName)
            
            self.pendingImageURL = url
            self.pendingImageName = sanitizedName.isEmpty ? "image_\(self.images.count + 1)" : sanitizedName
            self.showingImageNameDialog = true
        }
    }
    
    func confirmImageImport() {
        guard let url = pendingImageURL else { return }
        guard isValidName(pendingImageName) else { return }
        guard !imageNameExists(pendingImageName) else { return }
        
        if let image = NSImage(contentsOf: url) {
            let resource = ImageResource(name: pendingImageName, url: url, image: image)
            images.append(resource)
        }
        
        resetImageImport()
    }
    
    func cancelImageImport() {
        resetImageImport()
    }
    
    private func resetImageImport() {
        pendingImageURL = nil
        pendingImageName = ""
        showingImageNameDialog = false
    }
    
    func removeImage(_ image: ImageResource) {
        images.removeAll { $0.id == image.id }
    }
    
    func requestListingAdd() {
        newListingName = ""
        newListingContent = ""
        listingError = nil
        showingListingDialog = true
    }
    
    func confirmListingAdd() {
        listingError = nil
        
        guard !newListingName.isEmpty else {
            listingError = "Name cannot be empty"
            return
        }
        
        guard isValidName(newListingName) else {
            listingError = "Name can only contain letters, numbers, underscores and hyphens"
            return
        }
        
        guard !listingNameExists(newListingName) else {
            listingError = "Listing with this name already exists"
            return
        }
        
        guard !newListingContent.isEmpty else {
            listingError = "Content cannot be empty"
            return
        }
        
        let listing = ListingResource(name: newListingName, content: newListingContent)
        listings.append(listing)
        showingListingDialog = false
    }
    
    func cancelListingAdd() {
        showingListingDialog = false
    }
    
    func removeListing(_ listing: ListingResource) {
        listings.removeAll { $0.id == listing.id }
    }
    
    // MARK: - Helpers
    
    private func sanitizeName(_ name: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-")
        let sanitized = name.unicodeScalars.filter { allowedCharacters.contains($0) }
        return String(String.UnicodeScalarView(sanitized))
    }
    
    func isValidName(_ name: String) -> Bool {
        guard !name.isEmpty else { return false }
        return name.wholeMatch(of: validNameRegex) != nil
    }
    
    func imageNameExists(_ name: String) -> Bool {
        images.contains { $0.name == name }
    }
    
    private func listingNameExists(_ name: String) -> Bool {
        listings.contains { $0.name == name }
    }
    
    // MARK: - Accessors
    
    var parseResult: Result<Document, PageflowParseError>? {
        coordinator.result
    }
    
    var coordinatorInstance: PageflowParseCoordinator {
        coordinator
    }
    
    var suggestionsInstance: PageflowSuggestionDelegate {
        suggestions
    }
}

// MARK: - Models

struct ImageResource: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let url: URL
    let image: NSImage
}

struct ListingResource: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let content: String
}
