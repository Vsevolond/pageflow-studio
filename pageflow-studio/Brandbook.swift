//
//  Brandbook.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 01.12.2025.
//

import SwiftUI

extension Color {
    
    // MARK: - PageFlow Colors
    
    enum pageflow {
        
        // MARK: - Light Theme
        
        enum light {
            static let background = Color("colors/light/background")
            static let black = Color("colors/light/black")
            static let blue = Color("colors/light/blue")
            static let cyan = Color("colors/light/cyan")
            static let green = Color("colors/light/green")
            static let lightGreen = Color("colors/light/light-green")
            static let lightViolet = Color("colors/light/light-violet")
            static let pink = Color("colors/light/pink")
            static let red = Color("colors/light/red")
            static let teal = Color("colors/light/teal")
            static let violet = Color("colors/light/violet")
        }
        
        // MARK: - Dark Theme
        
        enum dark {
            static let background = Color("colors/dark/background")
            static let blue = Color("colors/dark/blue")
            static let cyan = Color("colors/dark/cyan")
            static let green = Color("colors/dark/green")
            static let lightGreen = Color("colors/dark/light-green")
            static let lightViolet = Color("colors/dark/light-violet")
            static let pink = Color("colors/dark/pink")
            static let red = Color("colors/dark/red")
            static let violet = Color("colors/dark/violet")
            static let white = Color("colors/dark/white")
            static let yellow = Color("colors/dark/yellow")
        }
    }
}
