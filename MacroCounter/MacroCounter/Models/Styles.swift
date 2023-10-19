//
//  Styles.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 21/08/23.
//

import SwiftUI

extension Date {
    func adding(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? Date.now
    }
}

struct TitleBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
            .bold()
    }
}

extension View {
    func blueTitleStyle() -> some View {
        modifier(TitleBlue())
    }
}

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var skyBlue: Color {
        Color(red: 0.4627, green: 0.8392, blue: 1.0)
    }
}
