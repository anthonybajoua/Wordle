//
//  WordleGameViewModel.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/19/22.
//

import Foundation

let kGameKey = "kABWordleGame"

class WordleGameViewModel: ObservableObject {
    @Published var game : WordleGame
    
    init() {
        if let data = UserDefaults.standard.object(forKey: kGameKey) as? Data,
           let potentialGame = try? JSONDecoder().decode(WordleGame.self, from: data) {
            game = potentialGame
        } else {
            game = WordleGame()
        }
        UserDefaults.standard.removeObject(forKey: kGameKey)
    }
    
    func tappedKey(_ key: WordleGame.Key) {
        game.tappedKey(key)
    }
    
    func submitWord() {
        game.submitWord()
    }
    
    func backspace() {
        game.backspace()
    }
    
    func saveGame() {
        if let encoded = try? JSONEncoder().encode(game) {
            UserDefaults.standard.set(encoded, forKey: kGameKey)
        }
    }
    
    func resetGame() {
        game.reset()
    }
}
