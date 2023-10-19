//
//  MacrosView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 27/07/23.
//

import CoreData
import SwiftUI

struct MacrosView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var goals: Goals
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var todaysFood: FetchedResults<CoreTodaysFood>
    @FetchRequest(sortDescriptors: []) var historic: FetchedResults<Historic>
    
    @State private var isShowingAlert = false
    @AppStorage("yesterday") private var yesterday = false
 
    private var totalKCal: Double {
        todaysFood.reduce(0.0) { total, food in
            total + food.kCal
        }}
    
    private var totalCarbs: Double {
        todaysFood.reduce(0.0) { total, food in
            total + food.carboidratos
        }}
            
    private var totalProt: Double {
        todaysFood.reduce(0.0) { total, food in
            total + food.proteinas
        }}
    
    private var totalGord: Double {
        todaysFood.reduce(0.0) { total, food in
            total + food.gorduras
        }}
    
    private var kCalBar: CGFloat {
        let calc = CGFloat(totalKCal)/CGFloat(goals.kCal)*100
        if calc <= 0 {
            return 0
        } else {
            return calc
        }
    }
    
    private var carbsBar: CGFloat {
        let calc = CGFloat(totalCarbs)/CGFloat(goals.carboidratos)*100
        if calc <= 0 {
            return 0
        } else {
            return calc
        }
    }
    
    private var protBar: CGFloat {
        let calc = CGFloat(totalProt)/CGFloat(goals.proteinas)*100
        if calc <= 0 {
            return 0
        } else {
            return calc
        }
    }
    
    private var gordBar: CGFloat {
        let calc = CGFloat(totalGord)/CGFloat(goals.gorduras)*100
        if calc <= 0 {
            return 0
        } else {
            return calc
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {                
                HStack {
                    Text(String(format: "Calorias (%.0f/\(goals.kCal))", totalKCal))
                        .font(.system(
                            .title3,
                            design: .rounded
                        ))
                        .fontWeight(.bold)
                    
                    Text(String(format: "[faltam: %.0f]", (totalKCal <= Double(goals.kCal) ? Double(goals.kCal) - totalKCal : 0)))
                        .font(.system(
                            .footnote,
                            design: .rounded
                        ))
                        .fontWeight(.light)
                }
                
                ProgressiveBarView(value: totalKCal, color1: viewModel.kCalGradient1, color2: viewModel.kCalGradient2, valueBar: kCalBar, goal: Double(goals.kCal), symbol: "bolt.circle.fill", symbolColor: .teal)
                
                HStack {
                    Text(String(format: "Carboidratos (%.0f/\(goals.carboidratos))", totalCarbs))
                        .font(.system(
                            .title3,
                            design: .rounded
                        ))
                    .fontWeight(.bold)
                    
                    Text(String(format: "[faltam: %.0f]", (totalCarbs <= Double(goals.carboidratos) ? Double(goals.carboidratos) - totalCarbs : 0)))
                        .font(.system(
                            .footnote,
                            design: .rounded
                        ))
                        .fontWeight(.light)
                }
                
                ProgressiveBarView(value: totalCarbs, color1: viewModel.carbsGradient1, color2: viewModel.carbsGradient2, valueBar: carbsBar, goal: Double(goals.carboidratos), symbol: "laurel.trailing", symbolColor: viewModel.laurelColor)
                
                HStack {
                    Text(String(format: "Proteínas (%.0f/\(goals.proteinas))", totalProt))
                        .font(.system(
                            .title3,
                            design: .rounded
                        ))
                    .fontWeight(.bold)
                    
                    Text(String(format: "[faltam: %.0f]", (totalProt <= Double(goals.proteinas) ? Double(goals.proteinas) - totalProt : 0)))
                        .font(.system(
                            .footnote,
                            design: .rounded
                        ))
                        .fontWeight(.light)
                }
                
                ProgressiveBarView(value: totalProt, color1: viewModel.protsGradient1, color2: viewModel.protsGradient2, valueBar: protBar, goal: Double(goals.proteinas), symbol: "fish.circle", symbolColor: viewModel.fishColor)
                
                HStack {
                    Text(String(format: "Gorduras (%.0f/\(goals.gorduras))", totalGord))
                        .font(.system(
                            .title3,
                            design: .rounded
                        ))
                    .fontWeight(.bold)
                    
                    Text(String(format: "[faltam: %.0f]", (totalGord <= Double(goals.gorduras) ? Double(goals.gorduras) - totalGord : 0)))
                        .font(.system(
                            .footnote,
                            design: .rounded
                        ))
                        .fontWeight(.light)
                }
                
                ProgressiveBarView(value: totalGord, color1: viewModel.gordsGradient1, color2: viewModel.gordsGradient2, valueBar: gordBar, goal: Double(goals.gorduras), symbol: "drop.degreesign", symbolColor: .purple)
                
            }
            .padding()
            .navigationTitle("Meus Macros")
            .preferredColorScheme(.dark)
            .toolbar {
                HStack {
                    Button {
                        isShowingAlert = true
                    } label: {
                        Label("", systemImage: "externaldrive.fill.badge.timemachine")
                    }
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("", systemImage: "gearshape")
                    }
                }
            }
            .alert("Iniciar novo Dia", isPresented: $isShowingAlert) {
                Button("Iniciar", role: .destructive) {
                    calcNSave()
                    
                    for i in todaysFood {
                        moc.delete(i)
                    }
                    
                    try? moc.save()
                }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("Tem certeza que deseja zerar o registro atual e iniciar outro?")
            }
        }
    }
    
    func calcNSave() {
        let newHistoric = Historic(context: moc)
        newHistoric.kCal = totalKCal
        newHistoric.carboidratos = totalCarbs
        newHistoric.proteinas = totalProt
        newHistoric.gorduras = totalGord
        newHistoric.date = yesterday ? Date.now.adding(hours: -24).formatted(date: .abbreviated, time: .omitted) : Date.now.formatted(date: .abbreviated, time: .omitted)
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

struct MacrosView_Previews: PreviewProvider {
    static var previews: some View {
        MacrosView()
            .environmentObject(Goals())
    }
}
