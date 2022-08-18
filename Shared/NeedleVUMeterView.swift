//
//  VUMeterView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct NeedleVUMeterView: View {
    @EnvironmentObject private var decibelSource: DecibelSource
    
    /// Change scale to -60dB to 0dB (more practical in most cases); Full scale is -120dB to 0dB
    @Binding var isHalfScale: Bool
    
    init(isHalfScale: Binding<Bool>) {
        self._isHalfScale = isHalfScale
    }
    
    private var halfScaleColors: [Color] {
        [Color("Ok"), Color("SemiHot"), Color("Hot")]
    }
    private var fullScaleColors: [Color] {
        [Color("Cold"), Color("Ok"), Color("Hot")]
    }
    
    private var minDb: Double {
        isHalfScale ? -60 : -120
    }
    
    var body: some View {
        let bgColor = Color(red: 231/255, green: 207/255, blue: 144/255, opacity: 1)
        let peakBGColor = Color("Hot")
        return GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Circle()
                    .trim(from: 0.5, to: 1.0)
                    .fill(
                        AngularGradient(gradient:
                                            Gradient(stops: [
                                                        Gradient.Stop(color: bgColor, location: 0),
                                                        Gradient.Stop(color: bgColor, location: isHalfScale ? 0.8 : 0.9),
                                                        Gradient.Stop(color: peakBGColor, location: isHalfScale ? 0.81 : 0.91)]
                                            ),
                                        center: .center, startAngle: .degrees(180), endAngle: .degrees(360))
                    )
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 4, height: min(geo.size.width, geo.size.height) / 2.5)
                    .offset(x: 0, y: -min(geo.size.width, geo.size.height) / 5)
                    .rotationEffect(
                        .degrees(
                            degreesFrom(decibels: decibelSource.decibels)
                        )
                    )
                    .animation(.easeInOut(duration: 1/5), value: decibelSource.decibels)
                Circle()
                    .fill(Color.black)
                    .frame(width: geo.size.width * 0.08)
            }
            .padding(.horizontal, geo.size.width * 0.05)
        }
    }
    
    func degreesFrom(decibels: Float) -> Double {
        let relDecibel = (Double(decibels) + minDb / -2.0) / -minDb
        let degrees: Double = max(min(relDecibel * 144.0, 85.0), -85.0)
        return degrees
    }
}

struct NeedleVUMeterView_Previews: PreviewProvider {
    static var previews: some View {
        NeedleVUMeterView(isHalfScale: .constant(true))
            .environmentObject(DecibelSource())
    }
}
