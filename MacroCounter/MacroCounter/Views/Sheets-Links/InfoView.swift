//
//  InfoView.swift
//  MacroCounter
//
//  Created by Daniel Corrêa on 19/09/23.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Tabela TACO")
                .font(.system(
                    .largeTitle,
                    design: .rounded
                ))
                .fontWeight(.bold)
            
            Text("""
             Os alimentos desta lista são compostos por 100 gramas de parte comestível. Os macronutrientes selecionados fazem parte e foram retirados da Tabela Brasileira de Composição de Alimentos / NEPA – UNICAMP.- 4. ed. rev. e ampl.. -- Campinas: NEPA- UNICAMP, 2011.
             
             Inclui referências.
             Nepa – Núcleo de Estudos e pesquisas em Alimentação.
             1. Composição – Alimentos – Tabelas. 2. Alimentos – Brasil. I. Universidade Estadual de Campinas.Núcleo de Estudos e Pesquisas em Alimentação. III. Título.
             CDD-641.10981
             """)
            .font(.custom(
                    "FontNameRound",
                    fixedSize: 18)
            )
            .padding()
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(.darkBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
        )
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
