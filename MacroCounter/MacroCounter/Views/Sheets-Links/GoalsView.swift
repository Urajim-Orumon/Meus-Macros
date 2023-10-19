//
//  GoalsView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 11/08/23.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var goals: Goals
    @Environment(\.dismiss) var dismiss

    let darkBlue = Color(red: 0.3, green: 0.1, blue: 0.9)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        Text("Calorias: ")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        TextField("kCal", value: $goals.kCal, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Spacer()
                        
                        Button {
                            goals.kCal = kCalCalc()
                        } label: {
                            Label("", systemImage: "lasso.and.sparkles")
                        }
                    }
                }
                
                HStack {
                    Text("Carboidratos:")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    
                    Spacer()
                    
                    TextField("Carboidratos", value: $goals.carboidratos, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Proteínas:")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    Spacer()
                    
                    TextField("Proteínas", value: $goals.proteinas, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Gorduras:")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    Spacer()
                    
                    TextField("Gorduras", value: $goals.gorduras, format: .number)
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
                        .foregroundColor(.white)
                        
                }
                .clipShape(Capsule())
                .onTapGesture {
                    dismiss()
                }
                .disabled(goals.kCal <= 0 || goals.carboidratos <= 0 || goals.proteinas <= 0 || goals.gorduras <= 0)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Minhas Metas")
        }
    }
    
    func kCalCalc() -> Int {
        var kCal = 0
        kCal += goals.carboidratos*4
        kCal += goals.proteinas*4
        kCal += goals.gorduras*9
        
        return kCal
    }
}

struct EscolherMetas_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
            .environmentObject(Goals())
    }
}
