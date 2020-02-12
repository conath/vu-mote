//
//  DecibelSource.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import Foundation

class DecibelSource: ObservableObject {
    @Published var decibels: Float = 1.0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1/15, repeats: true) { _ in
            // TODO Sensor data
            self.decibels = .random(in: 0.0...1.0)
        }
    }
}
