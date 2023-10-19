//
//  ContentView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 26/07/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        TabView {
            MacrosView()
                .tabItem {
                    Label("Meus Macros", systemImage: "fork.knife")
                }
            
            TodaysListView()
                .tabItem {
                    Label("Hoje", systemImage: "frying.pan.fill")
                }
            
            FoodListView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Spteps to follow:
//              About the app's engine:
//                  X create the JSON food list (now, just have to write. The list is already there)
//                  X import that list
//                  X create a separete view to that list
//                  X calculate kcal
//                  X calculate the portions
//                  X set food's time
//                  X set a "find loupe" in my food views
//                  X pin the favorites in the food list
//                  x make a button to get CoreTodaysFood empty and save that in historic
//                  X set a edit button to the TodaysFoodList and FoodList
//                  X make the rectangle progression
//                  X create the settings view. Make an Expandable List (medium website already openned)
//                      x Add an option to change the step.
//                      x Bring the macros settings.
//                      x Add "get in contact".
//                      x Add a place to save the mesures
//                      x Add a view to see each day
//                  X Add an Information button at toolbar talking about TACO
//                      x Use their table to make the json file
//                  - change for animatedButtonView the button in macrosView

//              About the View:
//                  x show the tips to start a new diet and set the tutorial rolling screen
//                  X on MacrosView, put big rectangles to fill up and insert some picture inside
//                  x make a nice color theme for the background
//                  X put some animations when press the buttons ("add food" and "save")
//                  X put the same color to the numbers of macros
//                  x change the frames for geometryreader
//                  x create a historic view

//              Bugs:
//                  - keyboard decimalpad complaining
//                  - insert dismiss on the keyboard 
