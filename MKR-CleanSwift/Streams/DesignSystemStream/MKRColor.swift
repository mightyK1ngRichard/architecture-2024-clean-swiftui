//
//  MKRColor.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 08.12.2024.
//

import UIKit
import SwiftUI

final class MKRColor<Palette: Hashable> {
    let color: Color
    let uiColor: UIColor

    init(hexLight: Int, hexDark: Int, alphaLight: CGFloat = 1.0, alphaDark: CGFloat = 1.0) {
        let lightColor = UIColor(hex: hexLight, alpha: alphaLight)
        let darkColor = UIColor(hex: hexDark, alpha: alphaDark)
        let uiColor = UIColor { $0.userInterfaceStyle == .light ? lightColor : darkColor }
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }

    init(hexLight: Int, hexDark: Int, alpha: CGFloat = 1.0) {
        let chmColor = MKRColor(hexLight: hexLight, hexDark: hexDark, alphaLight: alpha, alphaDark: alpha)
        self.uiColor = chmColor.uiColor
        self.color = chmColor.color
    }

    init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }
}

// MARK: - Palettes

enum TextPalette: Hashable {}
enum BackgroundPalette: Hashable {}
enum SeparatorPalette: Hashable {}

// MARK: - TextPalette

extension MKRColor where Palette == TextPalette {
    static let primary = MKRColor(hexLight: 0x000000, hexDark: 0xFEFEFE)
    static let primaryInverte = MKRColor(hexLight: 0xFFFFFF, hexDark: 0x2C2D2E)
    static let secondary = MKRColor(uiColor: .secondaryLabel)
    static let green = MKRColor(hexLight: 0x1DAF66, hexDark: 0x1DCB74)
}

// MARK: - BackgroundPalette

extension MKRColor where Palette == BackgroundPalette {
    /// Светлое тёмное
    static let bgLightCharcoal = MKRColor(hexLight: 0xFFFFFF, hexDark: 0x202020)
    /// Цвет фона кнопки
    static let bgButton = MKRColor(hexLight: 0x2D81E0, hexDark: 0xFFFFFF)
    /// Цвет шиммера
    static let bgShimmering = MKRColor(hexLight: 0xF3F3F7, hexDark: 0x242429)
    /// Цвет фона бейджа
    static let bgGreen = MKRColor(hexLight: 0xE4F8EE, hexDark: 0x203C2E)
    static let bgPurple = MKRColor(hexLight: 0xF2E6FE, hexDark: 0x3A2D53)
    static let bgPressedPurple = MKRColor(hexLight: 0xD3B6FB, hexDark: 0x4F416D)
    static let bgGray = MKRColor(hexLight: 0xFFFFFF, hexDark: 0x242429)
    static let bgPressedGray = MKRColor(hexLight: 0xD1D1E0, hexDark: 0x3B3B44)
}

// MARK: - SeparatorPalette

extension MKRColor where Palette == SeparatorPalette {
    static let primaryInverse = MKRColor(hexLight: 0xFEFEFE, hexDark: 0x000000)
    static let inlineButton = MKRColor(hexLight: 0x2688EB, hexDark: 0xFFFFFF)
    static let green = MKRColor(hexLight: 0x049C6B, hexDark: 0x049C6B)
}
