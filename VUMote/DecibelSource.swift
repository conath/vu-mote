//
//  DecibelSource.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import AVFoundation
import Accelerate

class DecibelSource: ObservableObject {
    @Published var decibels: Float = -120.0
    @Published var peak: Float = -120.0
    
    var decibelUpdateRate: TimeInterval = 1/30
    var peakUpdateRate: TimeInterval = 1/4
    
    init() {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupCaptureSession()
        
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
        
        case .denied: // The user has previously denied access.
            return

        case .restricted: // The user can't grant access due to restrictions.
            return
        default:
            return
        }
    }
    
    func setupCaptureSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .mixWithOthers)
            try audioSession.setActive(true)
            let captureSession = AVCaptureSession()
            captureSession.addInput(try! AVCaptureDeviceInput(device: AVCaptureDevice.default(for: .audio)!))
            let output = AVCaptureAudioDataOutput()
            captureSession.addOutput(output)
            captureSession.startRunning()
            
            // Update decibels quickly
            Timer.scheduledTimer(withTimeInterval: self.decibelUpdateRate, repeats: true) { _ in
                DispatchQueue.main.async {
                    let audioChannel = captureSession.connections[0].audioChannels.first!
                    self.decibels = audioChannel.averagePowerLevel
                }
            }
            // Update peak level more slowly
            Timer.scheduledTimer(withTimeInterval: self.peakUpdateRate, repeats: true) { _ in
                DispatchQueue.main.async {
                    let audioChannel = captureSession.connections[0].audioChannels.first!
                    self.peak = audioChannel.peakHoldLevel
                }
            }
            
        } catch {
            // no live VU for you
            print(error)
            return
        }
    }
}
