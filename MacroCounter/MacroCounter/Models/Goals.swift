//
//  Goals.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 11/08/23.
//

import SwiftUI

@MainActor class Goals: ObservableObject, Identifiable {
    @Published var kCal: Int {
        didSet {
            UserDefaults.standard.set(kCal, forKey: "MetasKCal")
        }
    }
    
    @Published var carboidratos: Int {
        didSet {
            UserDefaults.standard.set(carboidratos, forKey: "MetasCarbs")
        }
    }
    
    @Published var proteinas: Int {
        didSet {
            UserDefaults.standard.set(proteinas, forKey: "MetasProt")
        }
    }
    
    @Published var gorduras: Int {
        didSet {
            UserDefaults.standard.set(gorduras, forKey: "MetasGord")
        }
    }
        
    init() {
        let savedKCal = UserDefaults.standard.integer(forKey: "MetasKCal")
        kCal = savedKCal
        
        let savedCarbs = UserDefaults.standard.integer(forKey: "MetasCarbs")
        carboidratos = savedCarbs
        
        let savedProt = UserDefaults.standard.integer(forKey: "MetasProt")
        proteinas = savedProt
        
        let savedGord = UserDefaults.standard.integer(forKey: "MetasGord")
        gorduras = savedGord
    }
}
