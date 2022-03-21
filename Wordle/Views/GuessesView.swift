//
//  TextView.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/21/22.
//

import SwiftUI

let CORNER_RADIUS_GUESS : CGFloat = 20

struct GuessesView: View {
    @StateObject
    var viewModel = WordleGameViewModel()
    
    var body : some View {
        VStack {
            ForEach(viewModel.game.guesses.indices) {
                idx in GuessRowView(chars: viewModel.game.guesses[idx], viewModel: viewModel)
            }
        }
        EmptyView()
    }
}

private struct GuessRowView: View {
    var chars: [WordleGame.TextBox]
    var viewModel: WordleGameViewModel

    var body: some View {
        HStack {
            ForEach(chars.indices) {idx in
                GuessKeyView(txt: chars[idx], viewModel: viewModel)
            }
        }
    }
}

private struct GuessKeyView: View {
    var txt: WordleGame.TextBox
    var viewModel: WordleGameViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CORNER_RADIUS_GUESS)
                .stroke()
                .aspectRatio(1, contentMode: .fit)
                .background(
                    RoundedRectangle(cornerRadius: CORNER_RADIUS_GUESS)
                        .fill(colorForKey(state: txt.state))
                )
            Text(String(txt.content))
        }
    }
}


