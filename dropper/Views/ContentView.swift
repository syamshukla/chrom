//
//  ContentView.swift
//  dropper
//
//  Created by Syam Shukla on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = generateRandomCards(count: 5)
    @State private var offset = CGSize.zero
    @State private var toastMessage: String?
    @State private var showToast = false
    @State private var toastOpacity = 1.0 // Track opacity

    var body: some View {
        VStack {
            // Top Names Display
            if let card = cards.first {
                HStack {
                    Image(systemName: "eyedropper") // Eyedropper icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)

                    Text("Chrom")
                        .font(.largeTitle)
                        .padding(.leading, 8)
                }
                
                // Toast Message
                if showToast, let message = toastMessage {
                    Text(message)
                        .padding()
                        .background(message == "Correct!" ? Color.green : Color.red)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .transition(.move(edge: .top))
                        .opacity(toastOpacity)
                        .animation(.easeInOut(duration: 0.5), value: toastOpacity)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                // Card View
                CardView(card: card)
                    .offset(x: self.offset.width, y: 0)
                    .rotationEffect(.degrees(Double(self.offset.width / 10)))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { value in
                                if abs(self.offset.width) > 100 {
                                    // Check swipe direction against correctSide
                                    let isCorrect = (value.translation.width > 0 && card.correctSide == .right) ||
                                                    (value.translation.width < 0 && card.correctSide == .left)
                                    self.checkAnswer(isCorrect: isCorrect)
                                    self.removeTopCard()
                                }
                                self.offset = .zero
                            }
                    )
                    .animation(.spring(), value: self.offset)
            } else {
                Text("No more cards")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .padding(.top, 0)
        .onChange(of: showToast) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        toastOpacity = 0.0 // Fade out
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            showToast = false // Hide toast
                        }
                    }
                }
            }
        }
    }

    private func checkAnswer(isCorrect: Bool) {
            toastMessage = isCorrect ? "Correct!" : "Wrong!"
            showToast = true
            toastOpacity = 1.0 // Reset opacity when showing toast
        }

        private func removeTopCard() {
            cards.removeFirst()
            cards.append(generateRandomCard())
        }
}

func generateRandomCards(count: Int) -> [Card] {
    return (0..<count).map { _ in generateRandomCard() }
}

func generateRandomCard() -> Card {
    let hex1 = String(format: "#%06X", Int.random(in: 0...0xFFFFFF))
    let name1 = ColorNameFinder.shared.findClosestColorName(hex: hex1)

    var hex2: String
    var name2: String

    repeat {
        hex2 = String(format: "#%06X", Int.random(in: 0...0xFFFFFF))
        name2 = ColorNameFinder.shared.findClosestColorName(hex: hex2)
    } while name1 == name2 // Ensure name1 and name2 are not the same

    // Randomly assign the correct side
    let correctSide: SwipeDirection = Bool.random() ? .left : .right

    // Return card with the correct name assigned based on the random choice
    return correctSide == .left
        ? Card(hex: hex1, name1: name1, name2: name2, correctSide: .left)
        : Card(hex: hex2, name1: name2, name2: name1, correctSide: .right)
}


#Preview {
    ContentView()
}
