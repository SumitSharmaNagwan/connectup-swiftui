//
//  MainViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 20/03/23.
//

struct DataWrapper<T>{
    var data : T?
}

import Foundation
import SwiftUI
class MainViewModel : ObservableObject{
    @Published
    var data = DataWrapper<MyProfileModel>()
    let userApi = UserApi()
    // completionHandler: @escaping (_ result: T?)-> Void
    
    func refreshMyProfile(){
        userApi.getUserProfile { result in
            print(result?.name)
            self.data.data = result
        }
    }
    
    
    
}
