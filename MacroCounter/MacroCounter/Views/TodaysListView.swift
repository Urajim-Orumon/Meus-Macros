//
//  TodaysListView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 27/07/23.
//

import CoreData
import SwiftUI

struct TodaysListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.time)
    ])
    var todaysFood: FetchedResults<CoreTodaysFood>
    
    @State private var isShowingEdit = false
    @State private var selectedFood: CoreTodaysFood?
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todaysFood) { food in
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.gray, lineWidth: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            HStack {
                                Text("")
                                VStack(alignment: .leading) {
                                    Spacer()
                                    Text(food.name ?? "Unknown")
                                        .font(.headline)
                                    Spacer()
                                    Text(String(format: "(\(food.time ?? "(N/A)"))/%.0fg", (food.porcoes)))
                                        .foregroundColor(.secondary)
                                    Text("")
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Calorias: ")
                                    + Text(String(format: "%.0f", (food.kCal)))
                                        .foregroundColor(.green)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    
                                    Text("Carbs: ")
                                    + Text(String(format:"%.0f", (food.carboidratos)))
                                        .foregroundColor(skyBlue)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    
                                    Text("Proteínas: ")
                                    + Text(String(format: "%.0f",(food.proteinas)))
                                        .foregroundColor(.purple)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    
                                    Text("Gorduras: ")
                                    + Text(String(format: "%.0f",(food.gorduras)))
                                        .foregroundColor(lemonYellow)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                
                                Text("")
                            }
                        }
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                selectedFood = food
                                isShowingEdit = true
                            }
                    }
                    .sheet(item: $selectedFood) { selectedFood in
                        EditTodaysView(todaysFood: selectedFood)
                    }
                }
                .onDelete(perform: removeObject)
            }
            .navigationTitle("Lista de Hoje")
        }
    }
    
    func removeObject(at offsets: IndexSet) {
        for index in offsets {
            let food = todaysFood[index]
            moc.delete(food)
        }
        
        do {
            try moc.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct TodaysListView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysListView()
    }
}
