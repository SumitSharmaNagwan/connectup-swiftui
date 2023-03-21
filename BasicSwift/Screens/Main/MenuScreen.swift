//
//  MenuScreen.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Foundation
import SwiftUI

struct MenuScreen : View{
    var logoutUser : (LoginFlowScreen)->()
    var body: some View{
        VStack{
            HomeAppBar(title: "Menu")
            
                    Spacer()
            Text("Logout")
                .onTapGesture {
                    let firebaseAuth = Auth.auth()
                    do {
                      try firebaseAuth.signOut()
                        logoutUser(LoginFlowScreen.Splash)
                    } catch let signOutError as NSError {
                      print("Error signing out: %@", signOutError)
                    }
                }
            Spacer()
        }
    }
}

struct MenuScreenPreview : PreviewProvider {
    static var previews: some View{
        MainApp(){_ in
            
        }
    }
}
