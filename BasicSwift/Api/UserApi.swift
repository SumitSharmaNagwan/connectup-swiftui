//
//  UserApi.swift
//  BasicSwift
//
//  Created by remotestate on 17/03/23.
//

import Foundation

struct EndPoint{
    let endPoint: String
    let methodType : MethodType
}
struct UserApiEndPoints {
    
   static let userInfo = EndPoint(endPoint: "api/user/info", methodType: MethodType.get)
   static let userProfile = EndPoint(endPoint: "api/user/profile", methodType: MethodType.get)
   static let user = EndPoint(endPoint: "api/health", methodType: MethodType.get)
    
}

struct UserApi {
    
    // completionHandler: @escaping (_ result: T?)-> Void
    func getUserProfile(completionHandler : @escaping (_ result : MyProfileModel?) -> Void){
        HttpUtility.shared.apiCall(request: nil, methodType: UserApiEndPoints.userProfile.methodType, endPoint: UserApiEndPoints.userProfile.endPoint, resultType: MyProfileModel.self, completionHandler: completionHandler)
        
    }
    
    func getMyUserInfo(){
        HttpUtility.shared.apiCall(request: nil, methodType: UserApiEndPoints.userInfo.methodType, endPoint: UserApiEndPoints.userInfo.endPoint, resultType: String.self){result in }
        
    }
    
}
