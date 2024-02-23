//
//  ContentView.swift
//  GPT Gamble V5
//
//  Created by 64016641 on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var totalAmount = 0
    @State private var currentQuoteIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Lifetime Earnings: \(totalAmount)")
                .font(.headline)
                .padding()
            
            DragDropView(totalAmount: $totalAmount, currentQuoteIndex: $currentQuoteIndex)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DragDropView: View, DropDelegate {
    @Binding var totalAmount: Int
    @Binding var currentQuoteIndex: Int
    @State private var randomNumber: Int?
    
    let quotes = [
        "99% of gamblers quit before winning big",
        "you can only lose 100% but you can win over 2000%",
        "If you're running low on money, remember the mortgage!",
        "Your family isn't trying to help you, they're jealous of your winning mindset!",
        "It's not a loss until you quit!",
        "You're 32 rounds away from generational wealth!",
        "It's not a loss until you give up!",
        "History is made with risks!",
        "Your kids will thank you when you double their college funds!",
        "The probability you become a bazillionaire is 50%, either you do or you don't!",
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                IconView(imageName: "Mario-Coin")
                    .onDrag { NSItemProvider(object: "Mario-Coin" as NSString) }
                
                Spacer()
                
                IconView(imageName: "Casino")
                    .onDrag { NSItemProvider(object: "Casino" as NSString) }
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .onDrop(of: ["public.text"], delegate: self)
            
            Spacer()
            
            if let number = randomNumber {
                Text("You won! \(number) dollars")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            
            Text(quotes[currentQuoteIndex])
                .padding()
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(10)
                .padding()
        }
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if info.hasItemsConforming(to: ["public.text"]) {
            
            // Generate a random number
            var newRandomNumber: Int
            if Int.random(in: 0...100) > 40 {
                newRandomNumber = Int.random(in: -100...0)
            } else {
                newRandomNumber = Int.random(in: 0...100)
            }
            
            // Update total amount based on the random number
            totalAmount += newRandomNumber
            
            // Set the random number for display
            randomNumber = newRandomNumber
            
            // Cycle through quotes
            currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
            
            return true
        }
        return false
    }
}

struct IconView: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}





