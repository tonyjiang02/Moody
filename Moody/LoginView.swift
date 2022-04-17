//
//  LoginView.swift
//  Moody
//
//  Created by Tony Jiang on 4/16/22.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Namespace var animation
    @State var transition: Int? = 0

    @State var show = false

    var body: some View {
        
        VStack{
            // To change the view we have to use navigationlink
            // After the login success it will change to the HomeView()
            NavigationLink(destination: HomeView(), tag: 1, selection: $transition) {
                EmptyView()
            }
            Spacer(minLength: 0)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Login")
                        .font(.system(size: 40, weight: .heavy))
                        // for Dark Mode Adoption...
                        .foregroundColor(.primary)
                    
                    Text("Please sign in to continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading)
            
            CustomTextField(image: "envelope", title: "EMAIL", value: $email,animation: animation)
            
            CustomTextField(image: "lock", title: "PASSWORD", value: $password,animation: animation)
                .padding(.top,5)
            
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password){ (res, err) in
                    if err != nil{
                        // if there are any error it will show the error
                        // And the login will not complete
                        print(err!.localizedDescription)
                        return
                    }
                    // To navigate to the user page or after login page
                    self.transition = 1
                }
            }) {
                
                HStack(spacing: 10){
                    
                    Text("LOGIN")
                        .fontWeight(.heavy)
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
            
            Spacer(minLength: 0)
            
//            HStack(spacing: 8){
//
//                Text("Don't have an account?")
//                    .fontWeight(.heavy)
//                    .foregroundColor(.gray)
//            }
//            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
