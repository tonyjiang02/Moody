//
//  CameraService.swift
//  Moody
//
//  Created by Tony Jiang on 4/17/22.
//

import Foundation
import AVFoundation

class CameraService: ObservableObject {
    @Published var cameraEnabled: Bool = false
    
    init() {
        initPermissions()
    }
    func initPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
            self.cameraEnabled = true
            
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        self.cameraEnabled = true
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        }
    }
}
