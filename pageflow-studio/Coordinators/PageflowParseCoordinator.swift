//
//  PageflowParseCoordinator.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import Foundation
import Combine

import PageflowSourceEditor
import PageflowLanguage
import SwiftTreeSitter

enum PageflowParseError: Error, Equatable {
    case syntax(range: NSRange)
    case unknown(file: String, range: NSRange)
    case invalidExpression(range: NSRange)
    case invalidOperation(String, range: NSRange)
}

final class PageflowParseCoordinator: TextViewCoordinator, ObservableObject {
    
    // MARK: - Internal Properties
    
    @Published var result: Result<Document, PageflowParseError> = .success(.blank)
    
    // MARK: - Private Properties
    
    private var parser: ASTParser?
    private var task: Task<Void, Never>?
    
    private weak var provider: FileSuggestionsProvider?
    
    private lazy var pageflowParser: Parser = {
        let parser = Parser()
        
        if let language = CodeLanguage.pageflow.language {
            try? parser.setLanguage(language)
        }
        
        return parser
    }()
    
    // MARK: - Initializers
    
    init(provider: FileSuggestionsProvider) {
        self.provider = provider
    }
    
    // MARK: - Internal Methods
    
    func prepareCoordinator(controller: TextViewController) {
        guard parser == nil else { return }
        
        self.parser = ASTParserImpl(controller: controller)
    }
    
    func textViewDidChangeText(controller: TextViewController) {
        if let currentTask = task {
            currentTask.cancel()
            task = nil
        }
        
        let parseTask = Task {
            guard !Task.isCancelled else { return }
            
            do {
                try await Task.sleep(for: .seconds(2))
                parse(text: controller.text)
                
            } catch { return }
        }
        
        self.task = parseTask
    }
    
    // MARK: - Private Methods
    
    private func parse(text: String) {
        guard let mutableTree = pageflowParser.parse(text),
              let tree = mutableTree.copy()
        else {
            return
        }
        
        parse(tree: tree)
    }
    
    private func parse(tree: Tree) {
        guard let parser, let provider else { return }
        
        do {
            let document = try parser.parse(tree)
            
            let storage = ASTStorage(
                images: provider.images,
                listings: provider.listings
            )
            
            validate(document: document, with: storage)
            
        } catch {
            switch error {
            case .unknown(let range):
                let syntaxError = PageflowParseError.syntax(range: range)
                
                DispatchQueue.main.async {
                    self.result = .failure(syntaxError)
                }
            }
        }
    }
    
    private func validate(document: Document, with storage: ASTStorage) {
        do {
            try document.validate(with: storage)
            
            DispatchQueue.main.async {
                self.result = .success(document)
            }
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                handle(error: error)
            }
        }
    }
    
    private func handle(error: ASTError) {
        switch error {
        case .unknown(let file):
            let fileError = PageflowParseError.unknown(
                file: file.value,
                range: file.range
            )
            
            self.result = .failure(fileError)
            
        case .invalid(let expression):
            let expressionError = PageflowParseError.invalidExpression(range: expression.range)
            
            self.result = .failure(expressionError)
            
        case .invalidAdd(let operation):
            let operationError = PageflowParseError.invalidOperation(
                operation.value.rawValue,
                range: operation.range
            )
            
            self.result = .failure(operationError)
            
        case .invalidMul(let operation):
            let operationError = PageflowParseError.invalidOperation(
                operation.value.rawValue,
                range: operation.range
            )
            
            self.result = .failure(operationError)
        }
    }
}
