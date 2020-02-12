//
//  ContentView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isHalfScale = true
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                VUMeterView(isHalfScale: $isHalfScale)
                    .frame(width: 50.0, height: 300.0)

                NiceToggle(isEnabled: $isHalfScale)
                    .padding()
                
                Text(isHalfScale ? "Scale:  -60dB to 0dB" : "Scale: -120dB to 0dB")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(Color(UIColor.lightText))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
