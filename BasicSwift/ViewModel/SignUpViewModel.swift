//
//  LoginViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import Firebase
import GoogleSignIn

class SignUpViewModel: ObservableObject{
    @Published var isLogin : Bool = false
    
    func signUpWithGoogle( onLogin: @escaping (Bool)->()){
       
       // let clintId = FirebaseApp.app()?.options.clientID
        
       // let config = GIDConfiguration(clientID: clintId!)
        
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
                    onLogin(true)
                }
                print(r)
                
            }
        signInWithCredentials()
        }
        
    }
    
    func signInWithCredentials(){
        
    }
}
