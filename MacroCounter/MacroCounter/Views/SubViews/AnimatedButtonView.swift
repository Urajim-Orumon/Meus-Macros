//
//  AnimatedButtonView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 12/09/23.
//

import SwiftUI

struct AnimatedButtonView: View {
    @Environment(\.managedObjectContext) var moc
    
    let food: CoreFood
    
    @State private var plusAnimationAmount: CGFloat = 0.0
    
    @AppStorage("porcao") private var porcao = 60.0
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)
    let steelGray = Color(white: 0.4745)
    
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(stiffness: 8, damping: 1.5)) {
                        plusAnimationAmount += 360
                    }
                    
                    addToTodays(food: food)
                    try? moc.save()
                }
                .rotation3DEffect(.degrees(plusAnimationAmount), axis: (x: 0, y: 1, z: 0))
                            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.gray, lineWidth: 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack {
                    Text(food.name ?? "N/A")
                        .padding()
                        .font(.system(size: food.name?.count ?? "N/A".count >= 25 ? 14 : 16,
                                      weight: .bold,
                                      design: .rounded
                                     ))
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("KCal: ")
                        + Text(String(format: "%.0f",(food.kCal)))
                            .foregroundColor(.green)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        
                        Text("Carbs: ")
                        + Text(String(format:"%.0f", (food.carboidratos)))
                            .foregroundColor(skyBlue)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        
                        Text("Proteínas: ")
                        + Text(String(format: "%.0f",(food.proteinas)))
                            .foregroundColor(.purple)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        
                        Text("Gorduras: ")
                        + Text(String(format: "%.0f",(food.gorduras)))
                            .foregroundColor(lemonYellow)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                    }
                    Text("")
                }
            }
        }
    }

    func addToTodays(food: CoreFood) {
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
}

struct AnimatedButtonView_Previews: PreviewProvider {
   // @State private static var previewAnimationAmount: CGFloat = 1.0 // Simulate a binding variable

    static var previews: some View {
        Group {
            AnimatedButtonView(food: CoreFood())
        }
    }
}
