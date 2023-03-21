//
//  LoginScreen.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginScreen : View{
    @EnvironmentObject var userInfoEnv : UserInfoEvn
    var viewModel = SignUpViewModel()
    var loginCallBack : ( Bool) ->()
    var body : some View{
        VStack{
            Text("Login Screen")
                .onTapGesture {
                    
                 let userinfo =   UserInfo()
                    userinfo.name = "Sumit"
                    userinfo.isLogin = true
                   // userInfoEnv.userInfo = userinfo
                   var user = Auth.auth().currentUser
                    if(user == nil){
                        viewModel.signUpWithGoogle()
                    }else{
                        print(user?.displayName)
                    }
                    
                }
        }
    }
}


/*
struct Login_Preview : PreviewProvider{
    static var previews: some View{
    
        LoginScreen(loginCallBack: { isLogin in
            
        })
    }
    
}

*/
