//
//  ContentView.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var viewModel = WordleGameViewModel()
    
    var body: some View {
        VStack {
            GuessesView(viewModel: viewModel).padding()
            KeyboardView(viewModel: viewModel).padding()
        }.onAppWentToBackground {
            viewModel.saveGame()
          }
    }
}

extension View {
  func onAppCameToForeground(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
       action()
    }
  }

  func onAppWentToBackground(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
      action()
    }
  }
}
