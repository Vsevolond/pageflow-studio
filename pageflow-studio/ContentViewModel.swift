//
//  ContentViewModel.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 25.02.2026.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject, FileSuggestionsProvider {
    
    @Published var images: [String] = ["first", "some"]
    @Published var listings: [String] = ["main", "lab1"]
}
