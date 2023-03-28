//
//  ChatApi.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation
import Foundation
import SwiftUI



struct ChatEndPoints {
    
   static let matchConnection = EndPoint(endPoint: "api/user/connections/all", methodType: MethodType.get)
   static let chatGroupsList = EndPoint(endPoint: "api/chat/chat_group", methodType: MethodType.get)
}

struct ChatApi {
    
    
    func matchConnection(newMatchedOnly:Bool, completionHandler: @escaping (_ result: Array<MatchConnection>?)-> Void  ){
        
        let queryItems = [
            URLQueryItem(name: "newMatchedOnly", value: "\(newMatchedOnly)")
        ]
        
      //  HttpUtility.shared.apiCall(request: nil  , methodType: ChatEndPoints.matchConnection.methodType, endPoint: //ChatEndPoints.matchConnection.endPoint, resultType: Array<MatchConnection>.self, completionHandler: completionHandler, query: //queryItems)
    }
    
    func getchatGroupList( completionHandler: @escaping (_ result: Array<ChatListItem>?)-> Void  ){
      
       // HttpUtility.shared.apiCall(request: nil  , methodType: ChatEndPoints.chatGroupsList.methodType, endPoint: //ChatEndPoints.chatGroupsList.endPoint, resultType: Array<ChatListItem>.self, completionHandler: completionHandler)
    }

}
