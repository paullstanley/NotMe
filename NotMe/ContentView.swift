//
//  ContentView.swift
//  NotMe
//
//  Created by Paull Stanley on 11/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var isFlipping = false
    @State var isHeads = false
    @State var degreesToFlip: Int = 0
    @State var tailsCount: Int = 0
    @State var headsCount: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("Heads: \(headsCount)")
                Text("Tails: \(tailsCount)")
            }
            Spacer()
            Coin(isFlipping: $isFlipping, isHeads: $isHeads)
                .rotation3DEffect(Angle(degrees: Double(degreesToFlip)), axis: (x:CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            Spacer()
            Button("Flip Coin") {
                flipCoin()
            }
        }
        .padding()
    }
    func flipCoin() {
        withAnimation {
            let randomNumber = Int.random(in: 5...6)
            if degreesToFlip > 1800000000 {
                reset()
            }
            degreesToFlip = degreesToFlip + (randomNumber * 180)
            headsOrTails()
            isFlipping.toggle()
        }
    }
    
    func headsOrTails() {
        let divisible = degreesToFlip / 180
        (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
        isHeads == true ? (headsCount += 1) : (tailsCount += 1)
    }
    
    func reset() {
        degreesToFlip = 0
        
    }
}

struct Coin: View {
    @Binding var isFlipping: Bool
    @Binding var isHeads: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isHeads ? .gray : .orange)
                .frame(width: 100, height: 100)
                .overlay {
                    isHeads ? Text("Heads") : Text("Tails")
                    
                }
            Circle()
                .foregroundColor(isHeads ? .green : .yellow)
                .frame(width: 90, height: 90)
                .overlay {
                    isHeads ? Text("Heads") : Text("Tails")
                    
                }.rotation3DEffect(.degrees(isHeads ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
