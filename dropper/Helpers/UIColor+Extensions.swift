//
//  UIColor+Extensions.swift
//  dropper
//
//  Created by Syam Shukla on 7/15/24.
//

import Foundation
import SwiftUI
extension Color {
    init(hex: String) {
        let r, g, b: Double
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            r = Double((hexNumber & 0xff0000) >> 16) / 255
            g = Double((hexNumber & 0x00ff00) >> 8) / 255
            b = Double(hexNumber & 0x0000ff) / 255

            self.init(red: r, green: g, blue: b)
            return
        }

        self.init(red: 0, green: 0, blue: 0)
    }
}
