//
//  AspectVGrid.swift
//  Memorize
//
//  Created by CS193p Instructor on 4/24/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    var aspectRatio: CGFloat = 1
    let content: (Item) -> ItemView
    var minItemSize: CGFloat = 100
    
    init(_ items: [Item], aspectRatio: CGFloat, minItemSize: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minItemSize = minItemSize
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            if gridItemSize >= minItemSize {
                layoutItemsInGrid(itemSize: gridItemSize)
            } else {
                ScrollView {
                    layoutItemsInGrid(itemSize: minItemSize)
                }
            }
        }
    }
    
    @ViewBuilder
    private func layoutItemsInGrid(itemSize: CGFloat) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: itemSize), spacing: 0)], spacing: 0) {
            ForEach(items) { item in
                content(item)
                    .aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

