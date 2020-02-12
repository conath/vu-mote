//
//  ContentView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isEnabled = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                VUMeterView()
                    .frame(width: 50.0, height: 300.0)
                    .opacity(isEnabled ? 1.0 : 0.0)

                NiceToggle(isEnabled: $isEnabled)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
