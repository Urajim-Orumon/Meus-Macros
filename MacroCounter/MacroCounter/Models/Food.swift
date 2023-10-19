//
//  Food.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 27/07/23.
//

import SwiftUI

class Food: Identifiable, Codable, ObservableObject {
    var name: String
    var kCal: Double
    var carboidratos: Double
    var proteinas: Double
    var gorduras: Double
    var porcoes: Double
    
    init(name: String = "", kCal: Double = 0.0, carboidratos: Double = 0.0, proteinas: Double = 0.0, gorduras: Double = 0.0, porcoes: Double = 0.0) {
            self.name = name
            self.kCal = kCal
            self.carboidratos = carboidratos
            self.proteinas = proteinas
            self.gorduras = gorduras
            self.porcoes = porcoes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(kCal, forKey: .kCal)
        try container.encode(carboidratos, forKey: .carboidratos)
        try container.encode(proteinas, forKey: .proteinas)
        try container.encode(gorduras, forKey: .gorduras)
        try container.encode(porcoes, forKey: .porcoes)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        kCal = try container.decode(Double.self, forKey: .kCal)
        carboidratos = try container.decode(Double.self, forKey: .carboidratos)
        proteinas = try container.decode(Double.self, forKey: .proteinas)
        gorduras = try container.decode(Double.self, forKey: .gorduras)
        porcoes = try container.decode(Double.self, forKey: .porcoes)
    }
    
    enum CodingKeys: CodingKey {
            case name
            case kCal
            case carboidratos
            case proteinas
            case gorduras
            case porcoes
        }
}

//@MainActor class FoodList: ObservableObject {
//    @Published var foodList: [Food]
//
//    init() {
//        self.foodList = []
//    }
//
//    func addFood(_ food: Food) {
//        foodList.append(food)
//    }
//}
//
//@MainActor class TodaysFoodList: ObservableObject {
//    @Published var todaysFoodList: [Food]
//
//    init() {
//        self.todaysFoodList = []
//    }
//
//    func addFood(_ food: Food) {
//        todaysFoodList.append(food)
//    }
//}
