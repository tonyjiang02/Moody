//
//  MoodyApp.swift
//  Moody
//
//  Created by Tony Jiang on 4/16/22.
//

import SwiftUI
import FirebaseCore
@main
struct MoodyApp: App {
    
    init() {
        FirebaseApp.initialize()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
