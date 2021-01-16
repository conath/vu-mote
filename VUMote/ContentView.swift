//
//  ContentView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

internal enum VUMeterStyle: Int {
    case VFD, Needle
}

struct ContentView: View {
    @State var isHalfScale = true
    @State var vuMeterStyle: VUMeterStyle = .Needle
    @State var selected: Int = VUMeterStyle.Needle.rawValue
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                NiceToggle(isEnabled: $isHalfScale)
                    .padding()
                Text(isHalfScale ? "Scale:  -60dB to 0dB" : "Scale: -120dB to 0dB")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(Color(UIColor.lightText))
                
                switch vuMeterStyle.rawValue {
                case VUMeterStyle.VFD.rawValue:
                    VFDVUMeterView(isHalfScale: $isHalfScale)
                        .frame(width: 50.0, height: 300.0)
                        .transition(.identity)
                case VUMeterStyle.Needle.rawValue:
                    NeedleVUMeterView(isHalfScale: $isHalfScale)
                        .transition(.identity)
                default:
                    fatalError()
                }
                
                Spacer()
                
                RetroTabBar(selection: $selected,
                            images: [UIImage(systemName: "line.horizontal.3")!, UIImage(systemName: "dial.max")!],
                            selectItem: { (item) in
                    if let style = VUMeterStyle(rawValue: item) {
                        withAnimation {
                            vuMeterStyle = style
                            selected = item
                        }
                    }
                }, cornerRadius: 0)
                    .frame(height: 64)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
