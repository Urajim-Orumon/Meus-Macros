//
//  HistoricView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 16/09/23.
//

import SwiftUI

struct HistoricView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var historic: FetchedResults<Historic>
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(historic, id: \.self) { historic in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.gray, lineWidth: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        HStack {
                            Text("")
                            VStack(alignment: .leading) {
                                Text(historic.date ?? "Unknown")
                                    .font(.headline)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Calorias: ")
                                + Text(String(format: "%.0f", (historic.kCal)))
                                    .foregroundColor(.green)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                
                                Text("Carbs: ")
                                + Text(String(format:"%.0f", (historic.carboidratos)))
                                    .foregroundColor(skyBlue)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                
                                Text("Proteínas: ")
                                + Text(String(format: "%.0f",(historic.proteinas)))
                                    .foregroundColor(.purple)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                
                                Text("Gorduras: ")
                                + Text(String(format: "%.0f",(historic.gorduras)))
                                    .foregroundColor(lemonYellow)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                            }
                            .padding()
                        }
                    }
                }
                .onDelete(perform: removeObject)
            }
            .navigationTitle("Meu Histórico")
        }
    }
    
    func removeObject(at offsets: IndexSet) {
        for index in offsets {
            let food = historic[index]
            moc.delete(food)
        }
        
        do {
            try moc.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct HistoricView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricView()
    }
}
