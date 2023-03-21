//
//  MainViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 20/03/23.
//

import Foundation

class MainViewModel : ObservableObject{
    let userApi = UserApi()
    // completionHandler: @escaping (_ result: T?)-> Void
    
    func refreshMyProfile(){
        userApi.getUserProfile { result in
            print(result?.name)
        }
    }
    
    
    
}
