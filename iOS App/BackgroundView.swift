//
//  BackgroundView.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        let black = Color.black
        let darkest = Color("Darkest")
        let medium = Color("Medium")
        let gradient = Gradient(colors: [darkest, medium, darkest, black])
        return GeometryReader { geo in
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
