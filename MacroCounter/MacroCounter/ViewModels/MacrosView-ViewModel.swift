//
//  MacrosView-ViewModel.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 24/09/23.
//

import Foundation
import SwiftUI

extension MacrosView {
    @MainActor class ViewModel: ObservableObject {       
        @Published var laurelColor: Color = Color(#colorLiteral(red: 0.5311226249, green: 1, blue: 0, alpha: 1))
        @Published var fishColor: Color = Color(#colorLiteral(red: 1, green: 0.6695439816, blue: 0, alpha: 1))
        @Published var kCalGradient1 = Color(#colorLiteral(red: 0, green: 0.8987519145, blue: 0.8539252877, alpha: 1))
        @Published var kCalGradient2 = Color(#colorLiteral(red: 0, green: 0.8968694806, blue: 0, alpha: 1))
        @Published var carbsGradient1 = Color(#colorLiteral(red: 0, green: 0.7929498553, blue: 0.9898652434, alpha: 1))
        @Published var carbsGradient2 = Color(#colorLiteral(red: 0, green: 0.2165579796, blue: 0.7894411087, alpha: 1))
        @Published var protsGradient1 = Color(#colorLiteral(red: 0.9086939096, green: 0.4538508654, blue: 0.9506956935, alpha: 1))
        @Published var protsGradient2 = Color(#colorLiteral(red: 0.6410983801, green: 0.1797151566, blue: 0.9599587321, alpha: 1))
        @Published var gordsGradient1 = Color(#colorLiteral(red: 0.7630131841, green: 0.9300469756, blue: 0.447183013, alpha: 1))
        @Published var gordsGradient2 = Color(#colorLiteral(red: 0.9545634389, green: 0.7689097524, blue: 0.09182197601, alpha: 1))
    }
}
