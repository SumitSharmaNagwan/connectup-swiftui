//
//  LoginViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import Firebase
import GoogleSignIn
import Combine



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
    @Published var isShowLoader = false
    @Published var  loaderState = LoaderState()
    @Published var screenSubView : ScreenSubView = ScreenSubView.Main
    @Published var errorStatus = ErrorStatus(errorType: nil, message: nil, error: nil, serverErrorResponse: nil)
    var cancellable = Set<AnyCancellable>()
   
    
    private func errorHandle(error : Subscribers.Completion<ErrorStatus>){
        self.loaderState.isHide()
        
        switch error {
        case .failure(let errorStatus):
            let type =  errorStatus.errorType
            self.errorStatus = errorStatus
            switch type {
            case .Unauthorized :
                
                break
            case .BadRequest :
                
                self.screenSubView = ScreenSubView.InvalidInputPopup
                break
                
            default :
                break
            }
            print("")
            
        case .finished:
            print(" ")
        
        }

    }
    
    func loginWithEmailAndPasswod(onLogin : @escaping (Bool)->()){
        loaderState.show()
        let loginWithAuthRequest = LoginWithAuthRequest(appVersion: "String", fcmToken: "String", modelName: "String", osVersion: "String" ,token: "",email: self.email,password: self.password)
        
        self.loginApi.loginWithGoogle(loginWithAuthRequest: loginWithAuthRequest)
            .sink { [weak self] error in
                self?.errorHandle(error: error)
            } receiveValue: { [weak self]  result in
                let ct = result.customToken
                 
                 Auth.auth().signIn(withCustomToken: ct) { AuthDataResult, error1 in
                    let user = AuthDataResult?.user
                    
                     if user != nil{
                         onLogin(true)
                     }
                     self?.loaderState.isHide()
                 }
            }
            .store(in: &cancellable)

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
            self.loaderState.show()
            let loginWithAuthRequest = LoginWithAuthRequest(appVersion: "String", fcmToken: "String", modelName: "String", osVersion: "String" ,token: token)
            
            self.loginApi.loginWithGoogle(loginWithAuthRequest: loginWithAuthRequest)
                .sink { [weak self] error in
                    self?.errorHandle(error: error)
                } receiveValue: { [weak self] result in
                    let ct = result.customToken
                    self?.loaderState.isHide()
                     Auth.auth().signIn(withCustomToken: ct) { AuthDataResult, error1 in
                        let user = AuthDataResult?.user
                        
                         if user != nil{
                             onLogin(true)
                         }
                     }
                }
                .store(in: &self.cancellable)
            
        })
    }

}
