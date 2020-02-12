//
//  NiceToggle.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 12.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct NiceToggle: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        Text("On/Off")
            .font(.headline)
            .foregroundColor(.clear)
            .padding()
            .padding()
            .background(
                GeometryReader { geo in
                    return ZStack {
                        // Green bg if enabled
                        RoundedRectangle(cornerRadius: geo.size.height / 2)
                            .maskContent(using: RadialGradient(gradient: Gradient(colors: [Color("Medium"), Color.green]), center: .center, startRadius: 0, endRadius: geo.size.width / 2))
                            .offset(x: self.isEnabled ? -15 : 0, y: 0)
                        // Red bg if disabled
                        RoundedRectangle(cornerRadius: geo.size.height / 2)
                            .maskContent(using: RadialGradient(gradient: Gradient(colors: [Color("Medium"), Color.red]), center: .center, startRadius: 0, endRadius: geo.size.width / 2))
                            .offset(x: self.isEnabled ? 0 : 15, y: 0)
                        // Top part
                        RoundedRectangle(cornerRadius: geo.size.height / 2)
                            .maskContent(using: RadialGradient(gradient: Gradient(colors: [Color("Medium"), Color("Darkest")]), center: .center, startRadius: 0, endRadius: geo.size.height / 2))
                            .scaleEffect(1.01)
                    }
                }
            )
            .offset(x: isEnabled ? 15 : 0, y: 0)
            .padding(.trailing, 15)
            .onTapGesture {
                self.isEnabled.toggle()
            }
            .animation(.easeInOut)
    }
}

struct NiceToggle_Previews: PreviewProvider {
    @State static var enabled = true
    static var previews: some View {
        NiceToggle(isEnabled: $enabled)
    }
}
