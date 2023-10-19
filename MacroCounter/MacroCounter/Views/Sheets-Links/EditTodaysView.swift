//
//  EditTodaysView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 25/08/23.
//

import CoreData
import SwiftUI

struct EditTodaysView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
        
    @AppStorage("porcao") private var porcao = 60.0
    @AppStorage("step") private var step = 10.0
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    let darkBlue = Color(red: 0.3, green: 0.1, blue: 0.9)
    
    @State private(set) var todaysFood: CoreTodaysFood
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                Text("Redefina a Porção")
                    .font(.system(
                        .largeTitle,
                        design: .rounded
                    ))
                    .fontWeight(.bold)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.gray, lineWidth: 2)
                        .frame(maxWidth: .infinity, maxHeight: 120)
                    HStack {
                        Text("")
                        VStack(alignment: .leading) {
                            Text(todaysFood.name ?? "Unknown")
                                .font(.headline)
                            Text(String(format: "(\(todaysFood.time ?? "(N/A)"))/%.0fg", (todaysFood.porcoes)))
                                .foregroundColor(.secondary)
                            Text("")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("KCal: ")
                            + Text(String(format: "%.0f", (todaysFood.kCal)))
                                .foregroundColor(.green)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            
                            Text("Carbs: ")
                            + Text(String(format:"%.0f", (todaysFood.carboidratos)))
                                .foregroundColor(skyBlue)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            
                            Text("Proteínas: ")
                            + Text(String(format: "%.0f",(todaysFood.proteinas)))
                                .foregroundColor(.purple)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            
                            Text("Gorduras: ")
                            + Text(String(format: "%.0f",(todaysFood.gorduras)))
                                .foregroundColor(lemonYellow)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Porção em gramas:")
                        .padding()
                    
                    TextField("", value: $porcao, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Stepper("", value: $porcao, in: 0...10000, step: step)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(darkBlue)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    Text("Salvar")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    todaysFood.kCal = (todaysFood.kCal/todaysFood.porcoes)*porcao
                    todaysFood.carboidratos = (todaysFood.carboidratos/todaysFood.porcoes)*porcao
                    todaysFood.proteinas = (todaysFood.proteinas/todaysFood.porcoes)*porcao
                    todaysFood.gorduras = (todaysFood.gorduras/todaysFood.porcoes)*porcao
                    todaysFood.porcoes = porcao
                    
                    try? moc.save()
                    dismiss()
                }
                .clipShape(Capsule())
            }
            .padding()
        }
    }
}

struct EditTodaysView_Previews: PreviewProvider {
    static var previews: some View {
        EditTodaysView(todaysFood: CoreTodaysFood())
    }
}
