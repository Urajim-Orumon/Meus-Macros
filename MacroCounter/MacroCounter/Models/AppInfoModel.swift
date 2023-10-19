//
//  AppInfoModel.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 26/09/23.
//

import SwiftUI

class AppInfoModel: Identifiable, Codable, ObservableObject {
    @Published var title: String
    @Published var text: String
    @Published var tip: String
    
    init(title: String, text: String, tip: String) {
        self.title = title
        self.text = text
        self.tip = tip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(tip, forKey: .tip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        text = try container.decode(String.self, forKey: .text)
        tip = try container.decode(String.self, forKey: .tip)
    }
    
    enum CodingKeys: CodingKey {
        case title
        case text
        case tip
    }
}
