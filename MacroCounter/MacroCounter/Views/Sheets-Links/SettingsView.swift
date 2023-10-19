//
//  SettingsView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 26/08/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("step") private var step = 10.0
    @AppStorage("yesterday") private var yesterday = false
    
    let colorGreen = Color(#colorLiteral(red: 0.5003201962, green: 1, blue: 0.1913708448, alpha: 1))
    
    @State private var isShowingGoals = false
    @State private var isShowingGIC = false
    @State private var isShowingProgress = false
    @State private var isShowingCreateProgress = false
    @State private var isShowingHistoric = false
    @State private var isShowingAppInfo = false
    
    @State private var isStepExpanded = false
    @State private var isGICExpanded = false
    @State private var isProgressExpanded = false
    
    
    let lightBackground = Color(red: 0.2, green: 0.2, blue: 0.3)
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Escolher Minhas Metas")
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "flag.and.flag.filled.crossed")
                            .padding()
                            .foregroundStyle(colorGreen)
                            .onTapGesture {
                                isShowingGoals = true
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    
                    HStack {
                        Text("Meu Histórico")
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "timer")
                            .padding()
                            .foregroundStyle(colorGreen)
                            .onTapGesture {
                                isShowingHistoric = true
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    
                    HStack {
                        Text("Informações e Dicas")
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "info.bubble.fill")
                            .padding()
                            .foregroundStyle(colorGreen)
                            .onTapGesture {
                                isShowingAppInfo = true
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    
                    VStack {
                        HStack {
                            Text("Meu Progresso")
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: isProgressExpanded ? "chevron.up.circle" : "chevron.down.circle")
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        isProgressExpanded.toggle()
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                        
                        if isProgressExpanded {
                            VStack {
                                HStack {
                                    Text("Registrar Meu Progresso")
                                        .padding()
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.uturn.up.square")
                                        .padding()
                                        .foregroundColor(.green)
                                        .onTapGesture {
                                            isShowingCreateProgress = true
                                        }
                                }
                                
                                HStack {
                                    Text("Ver Meu Progresso")
                                        .padding()
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.uturn.up.square")
                                        .padding()
                                        .foregroundColor(.green)
                                        .onTapGesture {
                                            isShowingProgress = true
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(.darkBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    
                    VStack {
                        HStack {
                            Text("Configurações de uso")
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: isStepExpanded ? "chevron.up.circle" : "chevron.down.circle")
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        isStepExpanded.toggle()
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                        
                        if isStepExpanded {
                            VStack {
                                HStack {
                                    Text("Variação da porção:")
                                    Text(String(format: "%.0f", step))
                                        .font(.headline)
                                    Stepper("", value: $step)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                                HStack {
                                    Text("Data do registro:")
                                    Toggle(yesterday ? "Ontem" : "Hoje", isOn:
                                            withAnimation {
                                        $yesterday                                        
                                    })
                                        .font(.headline)
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(.darkBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    
                    VStack {
                        HStack {
                            Text("Entre Em Contato")
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: isGICExpanded ? "chevron.up.circle" : "chevron.down.circle")
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        isGICExpanded.toggle()
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                        
                        if isGICExpanded {
                            VStack {
                                Text("Será um prazer receber sugestões ou qualquer contato. Envie um email para dcdev7@icloud.com")
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(.darkBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                }
            }
            .sheet(isPresented: $isShowingGoals) {
                GoalsView()
            }
            .sheet(isPresented: $isShowingProgress) {
                ProgressView()
            }
            .sheet(isPresented: $isShowingCreateProgress) {
                CreateProgressView()
            }
            .sheet(isPresented: $isShowingHistoric) {
                HistoricView()
            }
            .sheet(isPresented: $isShowingAppInfo) {
                AppInfoView()
            }
            .navigationTitle("Configurações")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
