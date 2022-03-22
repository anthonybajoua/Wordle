//
//  SkipPanel.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/21/22.
//

import SwiftUI

struct SkipPanel: View {
    @State
    private var showingAlert = false
    
    var viewModel : WordleGameViewModel
    
    var body : some View {
        Button("Skip") {
            showingAlert = true
        }.alert("The word was \(viewModel.game.word)", isPresented: $showingAlert) {
            Button("Continue", role: .cancel) {
                viewModel.resetGame()
            }
        }
    }
}
