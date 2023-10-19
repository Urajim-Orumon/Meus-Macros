//
//  ProgressView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 27/08/23.
//

import CoreData
import SwiftUI

struct ProgressView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var progresses: FetchedResults<Progress>
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
        
    var body: some View {
        NavigationView {
            List {
                ForEach(progresses) { progress in
                    VStack(alignment: .leading) {
                        Text(progress.date ?? "data inválida")
                            .font(.title)
                            .padding()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(String(format: "Peso: %.1fkg", (progress.weight)))
                                    .bold()
                                
                                Text("Ombros: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.shoulders)))
                                    .font(.caption)
                                
                                Text("Peitoral: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.chest)))
                                    .font(.caption)
                                
                                Text("Braço e: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.leftBiceps)))
                                    .font(.caption)
                                
                                Text("Braço d: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.rightBiceps)))
                                    .font(.caption)
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text("Cintura: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.waist)))
                                    .font(.caption)
                                
                                Text("Quadril: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.hip)))
                                    .font(.caption)
                                
                                Text("Coxa e: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.leftLeg)))
                                    .font(.caption)
                                
                                Text("Coxa d: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.rightLeg)))
                                    .font(.caption)
                                
                                Text("Panturrilha e: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.leftCalf)))
                                    .font(.caption)
                                
                                Text("Panturrilha d: ")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                + Text(String(format: "%.1fcm", (progress.rightCalf)))
                                    .font(.caption)
                            }
                            .padding()
                        }
                        .frame(maxWidth: . infinity)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                }
                .onDelete(perform: removeObject)
                .padding([.vertical, .bottom])
            }
            .navigationTitle("Meu Progresso")
        }
    }
    func removeObject(at offsets: IndexSet) {
        for index in offsets {
            let progress = progresses[index]
            moc.delete(progress)
        }
        
        do {
            try moc.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
