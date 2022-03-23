//
//  KeyboardView.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/21/22.
//

import SwiftUI

private let KEY_WIDTH : CGFloat = UIScreen.screenWidth / 13
private let KEY_HEIGHT : CGFloat = 2 * KEY_WIDTH
private let CORNER_RADIUS_KEY : CGFloat = 5

struct KeyboardView: View {
    @StateObject
    var viewModel = WordleGameViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.game.keyboardRows.indices, id:\.self) {idx in
                if (idx == viewModel.game.keyboardRows.count - 1) {
                    KeyboardRowView(keys: viewModel.game.keyboardRows[idx], lastRow: true, viewModel: viewModel)
                } else {
                    KeyboardRowView(keys: viewModel.game.keyboardRows[idx], viewModel: viewModel)
                }
            }
        }
    }
    
}

// UI for keyboard
private struct KeyboardRowView: View {
    var keys: [WordleGame.Key]
    var lastRow = false
    var viewModel: WordleGameViewModel
    
    
    var body: some View {
        HStack {
            if (lastRow) {
                EnterButton(viewModel: viewModel)
            }
            ForEach(keys.indices, id:\.self) {idx in
                KeyView(key: keys[idx], viewModel: viewModel)
            }
            if (lastRow) {
                BackButton(viewModel: viewModel)
            }
        }
    }
}

private struct BackButton: View {
    @ObservedObject
    var viewModel: WordleGameViewModel
    var body: some View {
        ZStack {
            Circle().stroke()
            Text("⌫")
        }.frame(width: KEY_WIDTH, height: KEY_HEIGHT, alignment: .center)
            .onTapGesture {
                viewModel.backspace()
            }
        .alert("Correct!", isPresented: $viewModel.game.isWinner) {
            Button("Next word", role: .cancel) {
                viewModel.resetGame()
            }
        }
        .alert("Incorrect, the word was \(self.viewModel.game.word)", isPresented: $viewModel.game.isLoser) {
            Button("Next word", role: .cancel) {
                viewModel.resetGame()
            }
        }
    }
}

private struct EnterButton: View {
    @State
    private var showingAlert = false
    
    let viewModel: WordleGameViewModel
    var body: some View {
        ZStack {
            Circle().stroke()
            Text("⏎")
        }.frame(width: KEY_WIDTH, height: KEY_HEIGHT, alignment: .center)
            .onTapGesture {
                viewModel.submitWord()
            }
    }
}

private struct KeyView: View {
    var key: WordleGame.Key
    var viewModel: WordleGameViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CORNER_RADIUS_KEY)
                .stroke()
                .background(
                    RoundedRectangle(cornerRadius: CORNER_RADIUS_KEY)
                        .fill(colorForKey(state: key.state))
                )
            Text(String(key.content))
        }.frame(width: KEY_WIDTH, height: KEY_HEIGHT, alignment: .center)
            .onTapGesture {
                viewModel.tappedKey(key)
            }
    }
}

