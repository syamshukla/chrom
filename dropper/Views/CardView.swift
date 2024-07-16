//
//  CardView.swift
//  dropper
//
//  Created by Syam Shukla on 7/15/24.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: card.hex))
                .cornerRadius(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 50)
                .padding(20)
        

            VStack {
                HStack {
                    // Display name1 on the correct side
                    if card.correctSide == .left {
                        Text(card.name1)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Text(card.name2)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text(card.name2)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Text(card.name1)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                Spacer()
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(20)
        
        .shadow(color: Color(hex:card.hex), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 10) // Reduce outer padding
        
    }
}


#Preview {
    CardView(card: Card(hex: "#6195ED", name1: "Name1", name2: "Name2", correctSide: .left))
}
