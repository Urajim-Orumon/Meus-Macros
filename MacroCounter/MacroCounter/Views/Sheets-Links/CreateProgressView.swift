//
//  CreateProgressView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 30/08/23.
//

import SwiftUI

struct CreateProgressView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    let darkBlue = Color(red: 0.3, green: 0.1, blue: 0.9)
    
    @State private var date = ""
    @State private var weight = 0.0
    @State private var shoulders = 0.0
    @State private var chest = 0.0
    @State private var leftBiceps = 0.0
    @State private var rightBiceps = 0.0
    @State private var waist = 0.0
    @State private var hip = 0.0
    @State private var leftLeg = 0.0
    @State private var rigthLeg = 0.0
    @State private var leftCalf = 0.0
    @State private var rightCalf = 0.0
    
    var body: some View {
        VStack {
            Text("")
            Group {
                Text("Registrar Meu Progresso")
                    .font(.system(
                        .largeTitle,
                        design: .rounded
                    ))
                    .fontWeight(.bold)
                
                HStack {
                    Text("Peso (kg): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("peso", value: $weight, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Ombros (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("ombros", value: $shoulders, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Peitoral (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("peitoral", value: $chest, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Braço Esquerdo (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("braço esquerdo", value: $leftBiceps, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Braço Direito (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("braço direito", value: $rightBiceps, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            Group {
                
                HStack {
                    Text("Cintura (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("cintura", value: $waist, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Quadril (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("quadril", value: $hip, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Panturrilha Esquerda (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("panturrilha esquerda", value: $leftCalf, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Panturrilha Direita (cm): ")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    TextField("panturrilha direita", value: $rightCalf, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
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
                let newProgress = Progress(context: moc)
                newProgress.date = Date.now.formatted(date: .abbreviated, time: .omitted)
                newProgress.weight = weight
                newProgress.shoulders = shoulders
                newProgress.chest = chest
                newProgress.leftBiceps = leftBiceps
                newProgress.rightBiceps = rightBiceps
                newProgress.waist = waist
                newProgress.hip = hip
                newProgress.leftLeg = leftLeg
                newProgress.rightLeg = rigthLeg
                newProgress.leftCalf = leftCalf
                newProgress.rightCalf = rightCalf
                newProgress.id = UUID()
                
                try? moc.save()
                dismiss()
            }
            .clipShape(Capsule())
        }
    }
}

struct CreateProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProgressView()
    }
}
