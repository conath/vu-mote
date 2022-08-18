//
//  ContentView.swift
//  Music Control and Visualizer
//
//  Created by Christoph Parstorfer on 18.08.22.
//  Copyright © 2022 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // test
    @EnvironmentObject private var decibelSource: DecibelSource
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack() {
                Spacer()
                
                VFDVUMeterView(isHalfScale: .constant(true))
                    .frame(width: 50.0, height: 300.0)
                    .transition(.identity)
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
