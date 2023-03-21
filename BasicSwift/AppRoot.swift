//
//  AppRoot.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import Foundation
import SwiftUI

enum LoginFlowScreen{
    case Splash, Welcome, Login, SignUp, MainApp
}

struct AppRootView : View {
   
    @EnvironmentObject var userInfoEvn : UserInfoEvn
    @State private var loginFlowScreen : LoginFlowScreen = LoginFlowScreen.Splash
   
    var body: some View{
        
        switch loginFlowScreen {
        case .Splash:
            SplashScreen(){ nextSreen in
                loginFlowScreen = nextSreen
            }
        
            
        case .Welcome:
            WelcomeScreen(){ nextSreen in
                loginFlowScreen = nextSreen
            }
        
            
        case .Login:
            LoginScreen(){ nextSreen in
                loginFlowScreen = nextSreen
            }
        
            
        case .SignUp:
            Text("splash")
        
            
        case .MainApp:
            MainApp(){ nextSreen in
                loginFlowScreen = nextSreen
            }
            
        }
     //   WelcomeScreen()
        
       // InputTextField(startIcon: "email", placeHolder: "Email", text: .constant("hello") )
        /*
        if(userInfoEvn.userInfo.isLogin){
            var userinfo = userInfoEvn.userInfo.name
          //  WelcomeScreen()
        }else{
            LoginScreen { Bool in
                
            }.environmentObject(userInfoEvn)
        }
        
        */
        
    }
    
}

