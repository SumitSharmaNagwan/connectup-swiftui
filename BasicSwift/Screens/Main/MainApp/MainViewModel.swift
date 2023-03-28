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
            
            switch (result?.status){
            case .Loading :
                print("flowTest loading")
                
            case .Success :
                print("flowTest success")
                print(result?.data?.name)
                self.data.data = result?.data
                
            case .Error :
                print("flowTest error")
                
            case .none:
                "flowTest : none "
            }
           
        }
    }
    
    
    
}
