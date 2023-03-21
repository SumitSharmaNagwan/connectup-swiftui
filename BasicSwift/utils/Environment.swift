//
//  Environment.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import Foundation

class UserInfo:   ObservableObject{
   @Published var name : String?
   @Published var isLogin : Bool = false
}


@MainActor class UserInfoEvn : ObservableObject {
    @Published var userInfo : UserInfo
    init( ) {
        self.userInfo = UserInfo()
        self.userInfo.name = nil
        self.userInfo.isLogin = false
    }
    
}
