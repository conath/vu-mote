//
//  VUMeterView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct VUMeterView: View {
    @ObservedObject private var decibelSource = DecibelSource()
    
    @State var colorOk = Color("Ok")
    @State var colorHot = Color("Hot")
    private var colors: [Color] {
        [colorOk, colorHot]
    }
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .center, endPoint: .top)

        return GeometryReader { geo in
            ZStack {
                // grey path
                Path({ (path: inout Path) in
                    let mutablePath = CGMutablePath()
                    mutablePath.move(to: CGPoint(x: geo.size.width/2, y: geo.size.height))
                    mutablePath.addLine(to: CGPoint(x: geo.size.width/2, y: 0))
                    path.addPath(Path(mutablePath.copy(dashingWithPhase: 0.0, lengths: [10.0])))
                }).stroke(lineWidth: geo.size.width)
                    .fill(Color.gray)
                // Colorful path
                Path({ (path: inout Path) in
                    let mutablePath = CGMutablePath()
                    mutablePath.move(to: CGPoint(x: geo.size.width/2, y: geo.size.height))
                    mutablePath.addLine(to:
                        CGPoint(x: geo.size.width/2,
                                y: CGFloat(
                                    floor(geo.size.height * CGFloat(1 - self.decibelSource.decibels) / 10.0) * 10.0
                                )
                        )
                    )
                    path.addPath(Path(mutablePath.copy(dashingWithPhase: 0.0, lengths: [10.0])))
                }).stroke(lineWidth: geo.size.width)
                    .fill(gradient)
            }
            .animation(.easeOut(duration: 0.2))
        }
    }
}

struct VUMeterView_Previews: PreviewProvider {
    static var previews: some View {
        VUMeterView()
    }
}
