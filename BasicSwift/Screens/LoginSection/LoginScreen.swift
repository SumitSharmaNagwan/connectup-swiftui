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
    @ObservedObject
    var viewModel = SignUpViewModel()
    var nextScreen : ( LoginFlowScreen) ->()
    var body : some View{
        VStack(spacing:0){
            LoginAppBar()
            Group{
                Text("Welcome back")
                    .font(.system(size: 32))
                    .foregroundColor(AppColors.grayScaleBlack)
                    .padding( .top,46)
                
                Text("Login to continue")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.grayScaleSoftBlack)
                    .padding(.top,8)
                InputTextField(startIcon: "email",placeHolder: "Email",text:  $viewModel.email)
                    .padding(.top,32)
                    .onReceive(viewModel.$email){ text in
                        print(text)
                    }
                
                InputTextField(startIcon: "lock",endIcon:"eye", placeHolder: "Password",text: $viewModel.password)
                    .padding(.top,16)
                
                Text("Forgot password?")
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(AppColors.grayScaleSoftBlack)
                    .font(.system(size: 14,weight: Font.Weight.medium))
                    .padding(16)
            }
            PrimaryButton(label: "Login",action: {
                viewModel.loginWithEmailAndPasswod { isLogin in
                    if isLogin {
                        nextScreen(LoginFlowScreen.MainApp)
                    }else {
                        print("login failed")
                    }
                }
            },
                        isDisable: false,   buttonColorSolid: ButtonColorSolid.Green )
            .padding(.horizontal,16)
            .padding(.top,32)
            
            ZStack{
                Divider()
                    
                    .padding(.horizontal,16)
                Text("Or sign in with")
                    .padding(.horizontal,16)
                    .background(AppColors.screenBackGround)
                    
            }
            .padding(.top,32)
                
            HStack(spacing:16){
                Image("google")
                    .frame(width: 48,height: 48)
                    .onTapGesture {
                    /*
                     let userinfo =   UserInfo()
                        userinfo.name = "Sumit"
                        userinfo.isLogin = true
                        userInfoEnv.userInfo = userinfo
                     */
                       var user = Auth.auth().currentUser
                        if(user == nil){
                            viewModel.signUpWithGoogle(){ isLogin in
                                nextScreen(LoginFlowScreen.MainApp)
                            }
                        }else{
                            nextScreen(LoginFlowScreen.MainApp)
                            print(user?.displayName)
                        }
                        
                    }
                Image("linkedIn")
                    .frame(width: 48,height: 48)
                Image("facebook")
                    .frame(width: 48,height: 48)
            }
            .padding(.top,16)
            
                
            HStack{
                Text("Don’t have an account? ")
                    .foregroundColor(AppColors.grayScaleSoftBlack)
                    .font(.system(size: 16))
                Text("Sign Up")
                    .foregroundColor(AppColors.grayScaleSoftBlack)
                    .font(.system(size: 16, weight: Font.Weight.bold))
            }
            .padding(.top,32)

            Spacer()
    
        }
    }
}



struct Login_Preview : PreviewProvider{
    static var previews: some View{
    
        LoginScreen() { _ in
            
        }
    }
    
}



/*
 
 
 data class LoginWithGoogleOrFacebookRequestOrLinkedIn(
     val appName: String = "connectUP",
     val appVersion: String,
     val fcmToken: String,
     val modelName: String,
     val osVersion: String,
     val platform: String = "Android",
     val deviceId: String = "xyz",
     val token : String ="",
     val email : String = "",
     val password : String = "",
     val isLinkedinSignIn :Boolean = false,
     val code : String = "",
     val redirectUri : String = ""
 )
 */
