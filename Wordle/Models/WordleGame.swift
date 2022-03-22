//
//  WordleGame.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/19/22.
//

import Foundation

struct WordleGame: Codable {
    
    static let NUM_GUESSES = 6
    static let NUM_LETTERS = 5
    
    static let KEY_MAP = [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "ZXCVBNM"
    ]
    
    static let EMPTY_BOX = TextBox(state: State.Empty)
    
    private(set) var guesses: [[TextBox]]!
    private(set) var keyboardRows: [[Key]]!
    private(set) var word: String!
    var isWinner = false
    var isLoser = false

    
    private var wordList: Set<String>!
    private var i = 0
    private var j = 0
    
    init() {
        if let path = Bundle.main.path(forResource: "WordList", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                wordList = Set(data.components(separatedBy: .newlines))
            } catch {
                print(error)
            }
        }
        reset()
    }
    
    mutating func reset() {
        guesses = []
        keyboardRows = []
        isWinner = false
        isLoser = false
        word = wordList.randomElement()?.uppercased() ?? "HAPPY"
        i = 0
        j = 0
        print("Wordle with \(word ?? "")")
        
        for i in 0..<WordleGame.NUM_GUESSES {
            guesses.append([])
            for _ in 0..<WordleGame.NUM_LETTERS {
                guesses[i].append(WordleGame.EMPTY_BOX)
            }
        }
        
        for i in 0..<WordleGame.KEY_MAP.count {
            keyboardRows.append([])
            for char in WordleGame.KEY_MAP[i] {
                keyboardRows[i].append(Key(content: String(char), state: State.Empty))
            }
        }
    }
    
    mutating func tappedKey(_ key: WordleGame.Key) {
        if (j < WordleGame.NUM_LETTERS) {
            guesses[i][j] = TextBox(content: key.content, state: State.Empty)
            j += 1
        }
    }
    
    mutating func submitWord() {
        if (j == 5) {
            var guess = ""
            for txtBox in guesses[i] {
                guess += txtBox.content
            }
                        
            if (wordList.contains(guess.lowercased())) {
                updateStates()
                if (word == guess) {
                    print("Correct guess")
                    isWinner = true
                } else {
                    if (i < WordleGame.NUM_GUESSES - 1) {
                        i += 1
                        j = 0
                    } else {
                        print("Loser")
                        isLoser = true
                    }
                }
            } else {
                // TODO handle not a word case
                print("Not a word")
            }
        }
    }
    
    mutating func backspace() {
        if (j > 0) {
            guesses[i][j-1] = WordleGame.EMPTY_BOX
            j -= 1
        }
    }
    
    private mutating func updateStates() {
        var jj = 0
        for c in word {
            if (String(c) == guesses[i][jj].content) {
                guesses[i][jj].state = .RightSpot
            }
            jj += 1
        }
        
        jj = 0
        
        for jj in guesses[i].indices {
            if (guesses[i][jj].state != .RightSpot) {
                if (word.contains(guesses[i][jj].content)) {
                    guesses[i][jj].state = .Present
                } else {
                    guesses[i][jj].state = .NotPresent
                }
            }
        }
        
        for ii in keyboardRows.indices {
            for jj in keyboardRows[ii].indices {
                for kk in guesses[i].indices {
                    
                    if (guesses[i][kk].content == keyboardRows[ii][jj].content) {
                        keyboardRows[ii][jj].state = guesses[i][kk].content == keyboardRows[ii][jj].content ?
                        max(keyboardRows[ii][jj].state, guesses[i][kk].state) : keyboardRows[ii][jj].state
                    }
                    
                }
            }
        }
        
    }
    
    enum State: Int, Comparable, Codable {
        static func < (lhs: WordleGame.State, rhs: WordleGame.State) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        case Empty, NotPresent, Present, RightSpot
    }
    
    struct TextBox: Identifiable, Codable {
        var id = UUID().uuidString
        var content: String = " "
        var state: State
    }
    
    struct Key: Identifiable, Codable {
        var id = UUID().uuidString
        var content: String
        var state: State
    }
}



