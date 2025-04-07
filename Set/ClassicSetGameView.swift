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
        VStack {
            CardView()
            Diamond()
        }
        .padding()
    }
}

struct CardView: View {
    let aspectRatio = 2.0 / 3.0
    let content: (any Shape)? = nil
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.fill(.white)
            base.strokeBorder(lineWidth: 2)
        }
            .aspectRatio(aspectRatio, contentMode: .fit)
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
    ClassicSetGameView()
}
