//
//  FriendsList.swift
//  Moody
//
//  Created by Tony Jiang on 4/17/22.
//

import SwiftUI

struct FriendsList: View {
    @State var friend: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Friends")
                Spacer()
                Image(systemName: "plus")
            }
            Divider()
            Text("Anan Wang")
            Divider()
            Text("Leilei Chan")
            Divider()
            Spacer()
        }.padding()
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
    }
}
