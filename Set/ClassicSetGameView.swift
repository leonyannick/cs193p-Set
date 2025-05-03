//
//  ContentView.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import SwiftUI

struct ClassicSetGameView: View {
    @ObservedObject var classicSet: ClassicSetGame
    
    let aspectRatio = 2.0 / 3.0
    
    var body: some View {
        VStack {
            cards
            HStack {
                threeNewCardsButton
                newGameButton
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(classicSet.cards, aspectRatio: aspectRatio, minItemSize: 100) { card in
            CardView(card: card, aspectRatio: aspectRatio)
                .onTapGesture { classicSet.choose(card) }
                .padding(1)
        }
            .animation(.default, value: classicSet.cards)
    }
    
    private var threeNewCardsButton: some View {
            Button(action: {
                classicSet.threeNewCards()
            }, label: {
                HStack {
                    Image(systemName: "rectangle.stack.fill")
                    Text("more cards")
                }
                    .foregroundColor(.black)
                    .font(.title)
            })
                .buttonStyle(.bordered)
        }
    
    private var newGameButton: some View {
            Button(action: {
                classicSet.newGame()
            }, label: {
                HStack {
                    Image(systemName: "shuffle")
                    Text("new Game")
                }
                    .foregroundColor(.black)
                    .font(.title)
            })
                .buttonStyle(.bordered)
        }
}

/// A view that displays a Set game card with a shape, color, shading, and amount, based on its model.
struct CardView: View {
    /// The card model containing visual attributes (shape, color, shading, and amount).
    let card: SetGame.Card
    
    /// The fixed aspect ratio for the card (2:3).
    let aspectRatio: CGFloat

    /// The view body that defines the layout and styling of the card.
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.fill(backgroundColor)
            base.strokeBorder(lineWidth: 2)

            GeometryReader { geometry in
                let cardHeight = geometry.size.height
                let cardWidth = geometry.size.width
                let shapeHeight = cardHeight / 3 * 0.8   // Always divide into 3 slots
                let shapeWidth = cardWidth * 0.8   // Adjust as needed for padding

                VStack(spacing: 4) {
                    ForEach(0..<amount, id: \.self) { _ in
                        shape
                            .frame(width: shapeWidth, height: shapeHeight)
                    }
                }
                .frame(width: cardWidth, height: cardHeight)
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }

    /// Returns a shape view with applied color and shading, based on the card's shape type.
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

    /// Applies both color and shading (via opacity) to a given shape and outlines it.
    ///
    /// - Parameter shape: The base shape to apply visual styling to.
    /// - Returns: A view with filled and stroked styling applied to the shape.
    private func applyColorAndShading(to shape: some Shape) -> some View {
        ZStack {
            shape
                .fill(shapeColor)
                .opacity(opacity)
            shape
                .stroke(shapeColor, lineWidth: 2)
        }
    }

    /// The number of shape symbols to display on the card.
    var amount: Int {
        card.amount.rawValue
    }

    /// The color to apply to the shape based on the card's color attribute.
    var shapeColor: Color {
        switch card.color {
        case .one:
                .purple
        case .two:
                .blue
        case .three:
                .orange
        }
    }

    /// The opacity to apply to the shape based on the card's shading attribute.
    var opacity: Double {
        switch card.shading {
        case .one:
            1.0       // Solid
        case .two:
            0.0       // Outline
        case .three:
            0.5     // Striped
        }
    }
    
    var backgroundColor: Color {
        switch card.selection {
        case .none:
            .white
        case .selected:
            .gray
        case .containedInValidSet:
            .green
        case .containedInInvalidSet:
            .red
        }
    }
}

///A diamond-like Shape
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var diamondPath = Path()
        diamondPath.move(to: CGPoint(x: rect.midX, y: rect.minY))
        diamondPath.addLine(to: CGPoint(x: rect.maxX - rect.width, y: rect.midY))
        diamondPath.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        diamondPath.addLine(to: CGPoint(x: rect.minX + rect.width, y: rect.midY))
        diamondPath.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return diamondPath
    }
}


#Preview {
    ClassicSetGameView(classicSet: ClassicSetGame())
}
