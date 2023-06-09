//
//  MainApp.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Foundation
import SwiftUI

struct MainApp : View{
    var logoutUser : (LoginFlowScreen)->()
    var body: some View{
        
        TabView{
            HomeScreen().tabItem {
                Image("homeIcon")
                Text("Home")
            }
            SearchScreen().tabItem {
                Image("searchIcon")
                Text("Search")
            }
            ChatListScreen().tabItem {
                Image("chatIcon")
                Text("Chat")
            }
            ProfileScreen().tabItem {
                Image("profileIcon")
                Text("Profile")
            }
            MenuScreen(){nextScreen in
                logoutUser(nextScreen)
            }.tabItem {
                Image("moreIcon")
                Text("Menu")
            }
        }
        
    }
}

struct MainAppPreview : PreviewProvider {
    static var previews: some View{
        MainApp(){_ in
            
        }
    }
}
