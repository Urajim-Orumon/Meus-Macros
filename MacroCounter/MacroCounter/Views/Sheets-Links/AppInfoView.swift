//
//  AppInfoView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 21/09/23.
//

import SwiftUI

struct AppInfoView: View {
    @State private var dicas: [AppInfoModel] = Bundle.main.decode("appInfoView.json")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Informações e Dicas")
                    .font(.system(
                        .largeTitle,
                        design: .rounded
                    ))
                    .fontWeight(.bold)
                
                List {
                    ForEach(dicas) { dica in
                        NavigationLink {
                            VStack(alignment: .center) {
                                Text(dica.title)
                                    .font(.system(
                                        .largeTitle,
                                        design: .rounded
                                    ))
                                    .fontWeight(.bold)
                                
                                Spacer()

                                Image(systemName: "info.bubble.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [.yellow, .teal],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                
                                Spacer()
                                                            
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(.secondary)
                                
                                Text(dica.text)
                                    .font(.custom(
                                            "FontNameRound",
                                            fixedSize: 18)
                                    )
                                
                                Spacer()
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(.secondary)
                                
                                HStack {
                                    Image(systemName: "lightbulb.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .foregroundStyle(
                                            .linearGradient(
                                                colors: [.yellow, .teal],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                    
                                    Text("Dica:")
                                        .font(.title)
                                }
                                    Text(dica.tip)
                                    
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundStyle(.secondary)
                                
                                Spacer()
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke()
                            }
                            .background(.darkBackground)
                        } label: {
                            Text(dica.title)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AppInfoView()
}
