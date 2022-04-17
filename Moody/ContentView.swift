//
//  ContentView.swift
//  Moody
//
//  Created by Tony Jiang on 4/16/22.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    var body: some View {
        Group{
            if Auth.auth().currentUser != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
