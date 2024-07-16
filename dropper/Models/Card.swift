//
//  Card.swift
//  dropper
//
//  Created by Syam Shukla on 7/15/24.
//

import Foundation

struct Card {
    let hex: String
    let name1: String
    let name2: String
    let correctSide: SwipeDirection
}
enum SwipeDirection {
    case left, right
}
