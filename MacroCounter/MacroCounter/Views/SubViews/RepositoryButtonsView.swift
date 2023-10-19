//
//  RepositoryButtonsView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 16/09/23.
//

import SwiftUI

struct RepositoryButtonsView: View {    
    @Environment(\.managedObjectContext) var moc
    
    let food: Food
    
    @State private var plusAnimationAmount: CGFloat = 0.0
    @State private var heartAnimationAmount: CGFloat = 0.0
    
    @AppStorage("porcao") private var porcao = 60.0
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 8, damping: 1.5)) {
                            plusAnimationAmount += 360
                        }
                        
                        withAnimation {
                            addToTodays(food: food)
                            try? moc.save()
                        }
                    }
                    .rotation3DEffect(.degrees(plusAnimationAmount), axis: (x: 0, y: 1, z: 0))
                                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.gray, lineWidth: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    HStack {
                        Text(food.name)
                            .padding()
                            .font(.system(size: food.name.count >= 25 ? 14 : 16,
                                          weight: .bold,
                                          design: .rounded
                                         ))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("KCal: ")
                                .foregroundColor(.secondary)
                            + Text(String(format: "%.0f",(food.kCal)))
                                .foregroundColor(.green)
                                                                    
                            Text("Carbs: ")
                                .foregroundColor(.secondary)
                            + Text(String(format:"%.0f", (food.carboidratos)))
                                .foregroundColor(skyBlue)
                            
                            Text("Proteínas: ")
                                .foregroundColor(.secondary)
                            + Text(String(format: "%.0f",(food.proteinas)))
                                .foregroundColor(.purple)
                            
                            Text("Gorduras: ")
                                .foregroundColor(.secondary)
                            + Text(String(format: "%.0f",(food.gorduras)))
                                .foregroundColor(lemonYellow)
                                //.font(.system(size: 18, weight: .semibold, design: .rounded))
                        }
                        Text("")
                    }
                }
                
                Image(systemName: "arrow.down.heart.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 8, damping: 1.5)) {
                            heartAnimationAmount += 360
                        }
                        
                        withAnimation {
                            addToFavorites(food: food)
                            try? moc.save()
                        }
                    }
                    .rotation3DEffect(.degrees(heartAnimationAmount), axis: (x: 1, y: 0, z: 0))
            }
        }
    }

    func addToTodays(food: Food) {
        let newFood = CoreTodaysFood(context: moc)
        newFood.name = food.name
        newFood.kCal = (food.kCal/food.porcoes)*porcao
        newFood.carboidratos = (food.carboidratos/food.porcoes)*porcao
        newFood.proteinas = (food.proteinas/food.porcoes)*porcao
        newFood.gorduras = (food.gorduras/food.porcoes)*porcao
        newFood.porcoes = porcao
        newFood.id = UUID()
        newFood.time = Date.now.formatted(date: .omitted, time: .shortened)
    }

    func addToFavorites(food: Food) {
        let newFood = CoreFood(context: moc)
        newFood.name = food.name
        newFood.kCal = food.kCal / food.porcoes
        newFood.carboidratos = food.carboidratos / food.porcoes
        newFood.proteinas = food.proteinas / food.porcoes
        newFood.gorduras = food.gorduras / food.porcoes
        newFood.porcoes = 0.0
        newFood.id = UUID()
        newFood.isPinned = false
        newFood.animationAmount = 0.0
    }

}

struct RepositoryButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryButtonsView(food: Food(name: "example", carboidratos: 0.0, proteinas: 0.0, gorduras: 0.0, porcoes: 0.0))
    }
}
