//
//  EditView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 24/08/23.
//

import CoreData
import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var kCal = 0.0
    
    @State private(set) var food: CoreFood
        
    let darkBlue = Color(red: 0.3, green: 0.1, blue: 0.9)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                Text("Editor")
                    .font(.system(
                        .largeTitle,
                        design: .rounded
                    ))
                    .fontWeight(.bold)
                
                HStack {
                    Text("Nome: ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("\(food.name ?? "Unknown")", text: Binding(
                        get: { self.food.name ?? ""},
                        set: { self.food.name = $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                ZStack {
                    HStack {
                        Text("Calorias: ")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        TextField("KCal: ", value: $kCal, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    }
                    HStack {
                        Spacer()
                        
                        Button {
                            kCal = kCalCalc(food: food)
                        } label: {
                            Label("", systemImage: "lasso.and.sparkles")
                        }
                    }
                }
                
                HStack {
                    Text("Carboidratos: ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("Carboidratos: ", value: Binding(
                        get: { self.food.carboidratos*100 },
                        set: { self.food.carboidratos = $0/100 }
                    ),
                              formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("Proteínas: ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("Proteínas: ", value: Binding(
                        get: { self.food.proteinas*100 },
                        set: { self.food.proteinas = $0/100 }
                    ),
                              formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("Gorduras: ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("Gorduras: ", value: Binding(
                        get: { self.food.gorduras*100 },
                        set: { self.food.gorduras = $0/100 }
                    ),
                              formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(darkBlue)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    Text("Salvar")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    food.kCal = kCal/100
                    try? moc.save()
                    dismiss()
                }
                .clipShape(Capsule())
            }
            .padding()
        }
        .onAppear {
            kCal += food.kCal*100
        }
    }
    
    func kCalCalc(food: CoreFood) -> Double {
        var kCal = 0.0
        kCal += food.carboidratos*400
        kCal += food.proteinas*400
        kCal += food.gorduras*900
        
        return kCal
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(food: CoreFood())
    }
}
