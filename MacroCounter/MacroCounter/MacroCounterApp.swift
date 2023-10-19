//
//  MacroCounterApp.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 26/07/23.
//

import SwiftUI

@main
struct MacroCounterApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Goals())
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

