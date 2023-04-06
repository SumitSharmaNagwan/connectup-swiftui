//
//  RecommendationApi.swift
//  BasicSwift
//
//  Created by remotestate on 20/03/23.
//

import Foundation
import SwiftUI
import Combine

struct SearchUserRequest : Encodable{
    let onlineOnly: Bool
    let searchText: String
    let newest: Bool
    let limit : Int
    let page : Int
}

struct RecommendationEndPoints {
    
   static let searchUser = EndPoint(endPoint: "api/user/all_recommendations", methodType: MethodType.post)
}

struct RecommendationApi {
    
    func searchUser(searchUserRequest: SearchUserRequest) -> PassthroughSubject<Array<SearchUserModel>, ErrorStatus >{
      
       return HttpUtility.shared.apiCall(request: searchUserRequest  , methodType: RecommendationEndPoints.searchUser.methodType, endPoint: RecommendationEndPoints.searchUser.endPoint, resultType: Array<SearchUserModel>.self )
    }
}
