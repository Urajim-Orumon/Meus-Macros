//
//  ProgressiveBarView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 24/09/23.
//

import SwiftUI

struct ProgressiveBarView: View {
    let value: Double
    let color1: Color
    let color2: Color
    var valueBar: CGFloat
    let goal: Double
    let symbol: String
    let symbolColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = geometry.size.width * 0.98
                        
            if valueBar.isNaN {
                VStack() {
                    ZStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                .frame(width: width, height: 42)
                                .foregroundColor(Color.white.opacity(0.1))
                            
                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                .frame(width: width, height: 42)
                                .background(
                                    LinearGradient(gradient: Gradient(
                                        colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                                )
                                .foregroundColor(.clear)
                        }
                        
                        Image(systemName: symbol)
                            .resizable()
                            .foregroundColor(Double(value) >= goal ? .yellow: symbolColor)
                            .frame(maxWidth: 30, maxHeight: 30)
                    }
                }
            } else {
                VStack() {
                    ZStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                .frame(width: width, height: 42)
                                .foregroundColor(Color.white.opacity(0.1))
                            
                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                .frame(
                                    width:
                                        valueBar >= 100 ? width : valueBar / 100 * width,
                                    height: 42
                                )
                                .background(
                                    LinearGradient(gradient: Gradient(
                                        colors: [
                                            valueBar >= 100 ? .gray : color1,
                                            valueBar >= 100 ? .red : color2
                                        ]),
                                                   startPoint: .leading, endPoint: .trailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                                )
                                .foregroundColor(.clear)
                        }
                        
                        Image(systemName: symbol)
                            .resizable()
                            .foregroundColor(Double(value) >= goal ? .yellow: symbolColor)
                            .frame(maxWidth: 30, maxHeight: 30)
                    }
                }
            }
        }
    }
}

#Preview {
    ProgressiveBarView(value: 0, color1: .gray, color2: .red, valueBar: 1.0, goal: 0.0, symbol: "star.circle", symbolColor: .teal)
        .environmentObject(Goals())
}
