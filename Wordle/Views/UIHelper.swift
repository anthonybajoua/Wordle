//
//  UIHelper.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/21/22.
//

import Foundation
import SwiftUI

private struct LightColors {
    static let rightSpotColor: Color = .green
    static let rightLetterColor: Color = .yellow
    static let wrongColor: Color = .gray
}

func colorForKey(state: WordleGame.State) -> Color {
    switch state {
    case .Empty:
        return Color.clear
    case .Present:
        return LightColors.rightLetterColor
    case .NotPresent:
        return LightColors.wrongColor
    case .RightSpot:
        return LightColors.rightSpotColor
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
