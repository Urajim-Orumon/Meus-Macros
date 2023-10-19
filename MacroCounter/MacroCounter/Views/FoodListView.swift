//
//  FoodListView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 27/07/23.
//

import CoreData
import SwiftUI

struct FoodListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CoreFood.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \CoreFood.isPinned, ascending: false),
        NSSortDescriptor(keyPath: \CoreFood.name, ascending: true)
    ]) var foods: FetchedResults<CoreFood>
    
    @State private var isShowingRepository = false
    
    @FocusState private var isFocused: Bool
    
    @AppStorage("porcao") private var porcao = 60.0
    @AppStorage("step") private var step = 10.0
    
    @State private var searchQuery = ""
    @State private var selectedFood: CoreFood? = nil
        
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    
    var filteredList: [CoreFood] {
        if searchQuery.isEmpty {
            return Array(foods)
        } else {
            return foods.filter { food in
                return food.name?.localizedCaseInsensitiveContains(searchQuery) == true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    TextField("Search", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($isFocused)
                }
                
                List {
                    ForEach(filteredList) { food in
                        VStack {
                            HStack {
                              //  AnimatedButtonView(food: food)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(.green)
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        withAnimation(.interpolatingSpring(stiffness: 8, damping: 1.5)) {
                                            food.animationAmount += 360
                                            
                                            calcNSave(food: food)
                                            try? moc.save()
                                        }
                                    }
                                    .rotation3DEffect(.degrees(food.animationAmount), axis: (x: 0, y: 1, z: 0))
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.gray, lineWidth: 2)
                                    
                                    HStack {
                                        Text("")
                                        Text(food.name ?? "Unknown")
                                            .font(.headline)
                                        
                                        Spacer()

                                        VStack(alignment: .trailing) {
                                            Text("KCal: ")
                                                .foregroundColor(.secondary)
                                            + Text(String(format: "%.0f",(food.kCal*100)))
                                                .foregroundColor(.green)
                                                                                    
                                            Text("Carbs: ")
                                                .foregroundColor(.secondary)
                                            + Text(String(format:"%.0f", (food.carboidratos*100)))
                                                .foregroundColor(skyBlue)
                                            
                                            Text("Proteínas: ")
                                                .foregroundColor(.secondary)
                                            + Text(String(format: "%.0f",(food.proteinas*100)))
                                                .foregroundColor(.purple)
                                            
                                            Text("Gorduras: ")
                                                .foregroundColor(.secondary)
                                            + Text(String(format: "%.0f",(food.gorduras*100)))
                                                .foregroundColor(lemonYellow)
                                                //.font(.system(size: 18, weight: .semibold, design: .rounded))
                                        }
                                        Text("")
                                    }
                                }
                              
                                VStack(spacing: 15) {
                                    if food.isPinned {
                                        Image(systemName: "pin.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.yellow)
                                            .onTapGesture {
                                                withAnimation {
                                                    food.isPinned.toggle()
                                                    
                                                    try? moc.save()
                                                }
                                            }
                                    } else {
                                        Image(systemName: "pin.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.gray)
                                            .onTapGesture {
                                                withAnimation {
                                                    food.isPinned.toggle()
                                                    
                                                    try? moc.save()
                                                }
                                            }
                                    }
                                    
                                    Image(systemName: "pencil.circle")
                                        .background(
                                            NavigationLink("", destination: EditView(food: food))
                                        )
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeObject)
                    .frame(maxWidth: .infinity)
                }
                .sheet(isPresented: $isShowingRepository) {
                    RepositoryView()
                }
                .toolbar {
                    HStack {
                        NavigationLink {
                            CreateFoodView()
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                        
                        Button {
                            isShowingRepository = true
                        } label: {
                            Label("", systemImage: "archivebox.circle")
                        }
                    }
                }
                HStack {
                    Text("Porção em gramas:")
                        .padding()
                    
                    TextField("", value: $porcao, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Stepper("", value: $porcao, in: 0...10000, step: step)
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        isFocused = false
                    }) {
                        Text("OK")
                    }
                }
            }
            .navigationTitle("Favoritos")
        }
    }
    
    func removeObject(at offsets: IndexSet) {
        for index in offsets {
            let food = foods[index]
            moc.delete(food)
        }
        
        do {
            try moc.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func calcNSave(food: CoreFood) {
        let newFood = CoreTodaysFood(context: moc)
        newFood.name = food.name
        newFood.kCal = food.kCal*porcao
        newFood.carboidratos = food.carboidratos*porcao
        newFood.proteinas = food.proteinas*porcao
        newFood.gorduras = food.gorduras*porcao
        newFood.porcoes = porcao
        newFood.id = UUID()
        newFood.time = Date.now.formatted(date: .omitted, time: .shortened)
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
