//
//  Offline_Quote.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/25.
//

import SwiftUI

struct Offline_Quote: View {
    let quotes: [String]
    var body: some View {
        VStack {
            Text("Offline Quote")
                .font(.title)
                .padding()
            
            Button(action: {
                let randomIndex = Int.random(in: 0..<quotes.count)
                let randomQuote = quotes[randomIndex]
                print("Random Quote: \(randomQuote)")
            }) {
                Text("Get Random Quote")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

