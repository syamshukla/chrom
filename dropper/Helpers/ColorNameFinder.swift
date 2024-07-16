//
//  ColorNameFinder.swift
//  dropper
//
//  Created by Syam Shukla on 7/15/24.
//
import JavaScriptCore
import Foundation

class ColorNameFinder {
    static let shared = ColorNameFinder()
    
    private init() {
        setupContext()
    }
    
    private let context: JSContext = JSContext()!
    
    private func setupContext() {
        if let ntcPath = Bundle.main.path(forResource: "ntc", ofType: "js") {
            do {
                let ntcScript = try String(contentsOfFile: ntcPath, encoding: .utf8)
                context.evaluateScript(ntcScript)
            } catch {
                print("Failed to load ntc.js: \(error.localizedDescription)")
            }
        } else {
            print("ntc.js file not found")
        }
    }
    
    func findClosestColorName(hex: String) -> String {
        let script = "ntc.name('\(hex)')[1]"
        let colorName = context.evaluateScript(script)?.toString()
        return colorName ?? "Unknown"
    }
}
