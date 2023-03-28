//
//  LoginApi.swift
//  BasicSwift
//
//  Created by remotestate on 17/03/23.
//

import Foundation


struct User: Decodable{
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

struct LoginInWithGoogleResponse : Decodable{
    let customToken : String
}

struct LoginApiEndPoints {
    
   static let loginWithGoogleFacebookLinketIn = EndPoint(endPoint: "api/login_v3", methodType: MethodType.post)
}

struct LoginApi {
    
    func loginWithGoogle(loginWithAuthRequest: LoginWithAuthRequest, completionHandler: @escaping (_ result: LoginInWithGoogleResponse?)-> Void  ){
        //HttpUtility.shared.apiCall(request: loginWithAuthRequest  , methodType: LoginApiEndPoints.loginWithGoogleFacebookLinketIn.methodType, endPoint: LoginApiEndPoints.loginWithGoogleFacebookLinketIn.endPoint, resultType: LoginInWithGoogleResponse.self, completionHandler: completionHandler)
    
    }
    
   
    
}
