//
//  HomeView.swift
//  Moody
//
//  Created by Tony Jiang on 4/16/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.2.fill")
                Spacer()
                Image(systemName: "person.fill")
            }.padding()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
