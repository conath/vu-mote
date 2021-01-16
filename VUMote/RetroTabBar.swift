//
//  RetroTabBar.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 16.01.21.
//  Copyright © 2021 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct RetroTabBar: View {
    @Binding var selection: Int
    @State var images: [UIImage]
    @State var selectItem: (Int) -> ()
    @State var cornerRadius: CGFloat = 8
    @State var strokeWidth: CGFloat = 2
    
    var body: some View {
        let count = images.count
        return GeometryReader { frame in
            HStack(alignment: .center, spacing: 0) {
                ForEach(Array(images.enumerated()), id: \.0) { (id, image) -> AnyView in
                    let selected = selection == id
                    return AnyView(
                        ZStack {
                            BackgroundView()
                                .mask(RoundedRectangle(cornerRadius: cornerRadius))
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .strokeBorder(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [], dashPhase: 0))
                            Image(uiImage: image.withRenderingMode(.alwaysTemplate))
                                .foregroundColor(Color(.systemGray2))
                        }
                        .frame(width: frame.size.width / CGFloat(count), height: frame.size.height)
                        .scaleEffect(selected ? 0.9 : 1.0)
                        .animation(.easeIn(duration: 0.15), value: selection)
                        .shadow(color: .black, radius: selected ? 4 : 0)
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: 40, pressing: { _ in }, perform: {
                            selectItem(id)
                        })
//                        .onTapGesture() {
//                            selectItem(id)
//                        }
                    )
                }
            }
        }
    }
}

struct RetroTabBar_Previews: PreviewProvider {
    static var previews: some View {
        RetroTabBar(selection: .constant(0), images: [
            UIImage(systemName: "dial.max")!,
            UIImage(systemName: "dial.max")!,
            UIImage(systemName: "dial.max")!,
            UIImage(systemName: "dial.max")!,
            UIImage(systemName: "dial.max")!
        ], selectItem: { _ in })
        .frame(height: 60)
    }
}
