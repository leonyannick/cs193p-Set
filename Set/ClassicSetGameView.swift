//
//  ContentView.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import SwiftUI

struct ClassicSetGameView: View {
    @ObservedObject var classicSet: ClassicSetGame
    
    var body: some View {
        ScrollView {
            VStack {
//                let card = classicSet.testCard
//                CardView(card: card)
                ForEach(classicSet.cards) { card in
                    CardView(card: card)
                }
                
            }
                .padding()
        }
    }
}

struct CardView: View {
    let aspectRatio = 2.0 / 3.0
    let card: SetGame.Card
    
    init(card: SetGame.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.fill(.white)
            base.strokeBorder(lineWidth: 2)
            
            HStack {
                ForEach(0..<amount, id: \.self) { _ in
                    shape
                }
            }
                .padding()
        }
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    @ViewBuilder
    private var shape: some View {
        switch card.shape {
        case .one:
            applyColorAndShading(to: Diamond())
        case .two:
            applyColorAndShading(to: Capsule())
        case .three:
            applyColorAndShading(to: Rectangle())
        }
    }
    
    private func applyColorAndShading(to shape: some Shape) -> some View {
        ZStack {
            shape
                .fill(color)
                .opacity(opacity)
            shape
                .stroke(color, lineWidth: 2)
        }
    }
    
    var amount: Int {
        card.amount.rawValue
    }
    
    var color: Color {
        switch card.color{
        case .one: .red
        case .two: .blue
        case .three: .green
        }
    }
    
    var opacity: Double {
        switch card.shading {
        case .one: 1
        case .two: 0
        case .three: 0.5
        }
    }
}

///Returns a diamond-like Shape
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var diamondPath = Path()
        diamondPath.move(to: CGPoint(x: rect.midX, y: rect.minY))
        diamondPath.addLine(to: CGPoint(x: rect.maxX - 0.2 * rect.width, y: rect.midY))
        diamondPath.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        diamondPath.addLine(to: CGPoint(x: rect.minX + 0.2 * rect.width, y: rect.midY))
        diamondPath.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return diamondPath
    }
}


#Preview {
    ClassicSetGameView(classicSet: ClassicSetGame())
}
