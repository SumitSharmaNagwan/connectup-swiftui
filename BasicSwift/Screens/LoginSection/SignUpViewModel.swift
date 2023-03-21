//
//  LoginViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import Firebase
import GoogleSignIn


struct LoginWithAuthRequest : Encodable{
   
    var appVersion: String = ""
    var fcmToken: String = ""
    var modelName: String = ""
    var osVersion: String = ""
    var token : String = ""
    var appName: String = "connectUP"
    var platform: String = "IOS"
    var deviceId: String = "xyz"
  
    var email : String = ""
    var password : String = ""
    var isLinkedinSignIn :Bool = false
    var code : String = ""
    var redirectUri : String = ""
}

struct LoginRequest : Encodable{
    let email: String
    let password: String
}


class SignUpViewModel: ObservableObject{
    let loginApi = LoginApi()
    @Published var isLogin : Bool = false
    @Published var email  = ""
    @Published var password  = ""
    
    
    func loginWithEmailAndPasswod(onLogin : @escaping (Bool)->()){
        let loginWithAuthRequest = LoginWithAuthRequest(appVersion: "String", fcmToken: "String", modelName: "String", osVersion: "String" ,token: "",email: self.email,password: self.password)
        
        self.loginApi.loginWithGoogle(loginWithAuthRequest: loginWithAuthRequest){result in
            print(result)
            if result != nil{
               let ct = result?.customToken
                
                Auth.auth().signIn(withCustomToken: ct!) { AuthDataResult, error1 in
                   let user = AuthDataResult?.user
                   
                    if user != nil{
                        onLogin(true)
                    }
                    
                    print(AuthDataResult)
                    
                    print(error1)
                }
                    
                
            }
        }
    }
    
    func signUpWithGoogle( onLogin: @escaping (Bool)->()){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn( withPresenting: ApplicationUtiles.rootViewController){
            [self] signResult, err in
            
            if let error  = err {
                print(error.localizedDescription)
                return
            }
            guard let user = signResult?.user,  let idToken = user.idToken  else { return }
        
            let accessToken = user.accessToken
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
            Auth.auth().signIn(with: credentials){authResult, error in
                let r = authResult?.user.displayName
                if r != nil{
                    
                    loginWithCustomToken(onLogin: onLogin)
                   // onLogin(true)
                }
                print(r)
                
            }
       
        }
        
    }
    
    func loginWithCustomToken (onLogin: @escaping (Bool)->()){
        
        let currentUser = Auth.auth().currentUser
        
        currentUser?.getIDTokenResult(forcingRefresh: true, completion: { tokenResult, error in
            let token = "Bearer "+(tokenResult?.token ?? "" )
            print(tokenResult?.token)
            
            let loginWithAuthRequest = LoginWithAuthRequest(appVersion: "String", fcmToken: "String", modelName: "String", osVersion: "String" ,token: token)
            
            self.loginApi.loginWithGoogle(loginWithAuthRequest: loginWithAuthRequest){result in
                print(result)
                if result != nil{
                   let ct = result?.customToken
                    
                    Auth.auth().signIn(withCustomToken: ct!) { AuthDataResult, error1 in
                       let name = AuthDataResult?.user.displayName
                        if name != nil{
                            onLogin(true)
                        }
                        
                        print(AuthDataResult)
                        
                        print(error1)
                    }
                        
                    
                }
            }
            
            
        })
    }

}
