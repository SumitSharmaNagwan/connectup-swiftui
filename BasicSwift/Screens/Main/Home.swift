//
//  Home.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//

import Foundation
import SwiftUI

struct HomeScreen:View{
   
    var body: some View{
        Text("Home")
            .onAppear{
               // loginApi.getPost()
               // userApi.getUserProfile()
            }
    }
        
}

struct HomeScreenPreview : PreviewProvider {
    static var previews: some View{
        HomeScreen()
    }
}
