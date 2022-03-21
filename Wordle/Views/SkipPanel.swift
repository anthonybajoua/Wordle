//
//  SkipPanel.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/21/22.
//

//import SwiftUI
//
//
//struct SkipPanel: View {
//    @State
//    private var showingAlert = false
//    
//    var viewModel : WordleGameViewModel
//    
//    var body : some View {
//        HStack {
//            Spacer()
//            ZStack {
//                RoundedRectangle(cornerRadius: CORNER_RADIUS_GUESS)
//                    .stroke()
//                Button("Skip") {
//                    showingAlert = true
//                    viewModel.resetGame()
//                }
//            }
//            Spacer()
//                .alert("The word was \(viewModel.game.word)", isPresented: $showingAlert) {
//                    Button("Continue", role: .cancel) {}
//                }
//        }
//    }
//}
