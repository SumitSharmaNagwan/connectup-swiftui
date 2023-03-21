//
//  AppRoot.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import Foundation
import SwiftUI

struct AppRootView : View {
   
    @EnvironmentObject var userInfoEvn : UserInfoEvn
   
    var body: some View{
     //   WelcomeScreen()
        
       // InputTextField(startIcon: "email", placeHolder: "Email", text: .constant("hello") )
        
        if(userInfoEvn.userInfo.isLogin){
            var userinfo = userInfoEvn.userInfo.name
            WelcomeScreen()
        }else{
            LoginScreen { Bool in
                
            }.environmentObject(userInfoEvn)
        }
        
        
    }
    
}

