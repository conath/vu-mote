//
//  Music_Control_and_VisualizerApp.swift
//  Music Control and Visualizer
//
//  Created by Christoph Parstorfer on 18.08.22.
//  Copyright © 2022 Christoph Parstorfer. All rights reserved.
//

import SwiftUI

@main
struct Music_Control_and_VisualizerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DecibelSource())
        }
    }
}
