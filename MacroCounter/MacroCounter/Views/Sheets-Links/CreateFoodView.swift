//
//  CreateFoodView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 08/08/23.
//

import CoreData
import SwiftUI

struct CreateFoodView: View {    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var foods: FetchedResults<CoreFood>
    
    let darkBlue = Color(red: 0.3, green: 0.1, blue: 0.9)
    
    @State private var name: String = ""
    @State private var kCal: Double = 0.0
    @State private var carboidratos: Double = 0.0
    @State private var proteinas: Double = 0.0
    @State private var gorduras: Double = 0.0
    @State private var porcoes: Double = 0.0
    
    var body: some View {
        VStack {
            Text("")
            Text("Crie um Novo Alimento")
                .font(.system(
                    .largeTitle,
                    design: .rounded
                ))
                .fontWeight(.bold)
            
            HStack {
                Text("Nome: ")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                TextField("Nome", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            ZStack {
                HStack {
                    Text("Calorias: ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("kCal", value: $kCal, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Spacer()
                    
                    Button {
                        kCal = kCalCalc()
                    } label: {
                        Label("", systemImage: "lasso.and.sparkles")
                    }
                }
            }
            
            HStack {
                Text("Carboidratos:")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                TextField("Carboidratos", value: $carboidratos, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Proteínas:")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                TextField("Proteínas", value: $proteinas, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Gorduras:")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                TextField("Gorduras", value: $gorduras, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Porção em gramas:")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                TextField("Porções", value: $porcoes, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(darkBlue)
                    .frame(maxWidth: .infinity, maxHeight: 50)

                Text("Salvar")
                    .font(.largeTitle)
                    .foregroundColor(porcoes <= 0 ? .gray : .white)
            }
            .onTapGesture {
                let newFood = CoreFood(context: moc)
                newFood.name = name
                newFood.kCal = kCal/porcoes
                newFood.carboidratos = carboidratos/porcoes
                newFood.proteinas = proteinas/porcoes
                newFood.gorduras = gorduras/porcoes
                newFood.porcoes = 0.0
                newFood.id = UUID()
                newFood.isPinned = false
                newFood.animationAmount = 0.0
                
                try? moc.save()
                dismiss()
            }
            .disabled(porcoes <= 0 && !name.isEmpty)
            .clipShape(Capsule())
        }
    }
    
    func kCalCalc() -> Double {
        var kCal = 0.0
        kCal += carboidratos*4
        kCal += proteinas*4
        kCal += gorduras*9
        
        return kCal
    }
}

struct CreateFoodView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFoodView()
    }
}
