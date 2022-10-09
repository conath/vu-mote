//
//  WaveFormView.swift
//  MusicCAV
//
//  Created by Christoph Parstorfer on 07.10.22.
//  Copyright © 2022 Christoph Parstorfer. All rights reserved.
//

import SwiftUI
import Waveform

struct WaveFormView: View {
    @EnvironmentObject private var decibelSource: DecibelSource
    /// Change scale to -60dB to 0dB (more practical in most cases); Full scale is -120dB to 0dB
    @Binding var isHalfScale: Bool
    
    private var minDb: Float {
        isHalfScale ? -60 : -120
    }
    
    var body: some View {
        let samples = convertFromDecibelToWaveSamples(samples: decibelSource.samples)
        return VStack {
            Waveform(samples: SampleBuffer(samples: samples))
            Waveform(samples: SampleBuffer(samples: samples))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0)
        }
    }
    
    private func convertFromDecibelToWaveSamples(samples: [Float]) -> [Float] {
        var conv = [Float]()
        let scale = abs(minDb)
        for sample in samples {
            conv.append((scale + 2 * sample) / scale)
        }
        
        return conv
    }
}
