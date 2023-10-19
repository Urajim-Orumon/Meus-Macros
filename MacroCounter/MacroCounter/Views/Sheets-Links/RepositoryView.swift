//
//  RepositoryView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 19/08/23.
//
import CoreData
import SwiftUI

struct RepositoryView: View {
    @Environment(\.dismiss) var dismiss

    @State private var repositorio: [Food] = Bundle.main.decode("repositorio.json")
    
    @AppStorage("porcao") private var porcao = 60.0
    @AppStorage("step") private var step = 10.0
    
    @State private var searchQuery = ""
    @State private var isShowingInfo = false
    
    var filteredList: [Food] {
        if searchQuery.isEmpty {
            return repositorio
        } else {
            return repositorio.filter { food in
                return food.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
            
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Banco de Dados")
                        .font(.system(
                            .largeTitle,
                            design: .rounded
                        ))
                    .fontWeight(.bold)
                    
                    Button {
                        isShowingInfo = true
                    } label: {
                        Label("", systemImage: "info.bubble")
                    }
                }
                
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    TextField("Search", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                List {
                    ForEach(filteredList) { food in
                        RepositoryButtonsView(food: food)
                            //.navigationTitle("Banco de Dados")
                    }
                }
                
                HStack {
                    Text("Porção em gramas:")
                        .padding()
                    
                    TextField("", value: $porcao, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Stepper("", value: $porcao, in: 0...10000, step: step)
                }
            }
            .sheet(isPresented: $isShowingInfo) {
                InfoView()
            }
        }
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}
