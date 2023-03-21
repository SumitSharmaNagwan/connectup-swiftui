//
//  SplashScreen.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


struct SplashScreen: View{
    var next : (LoginFlowScreen)->()
    var body: some View{
        ZStack{
            HStack(alignment: .center ){
                Spacer()
                VStack(alignment: .center ){
                    Spacer()
                   
                    Text("ConnectUp")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom,80)
                }
                Spacer()
            }
            Image("logoBlack")
            
        }.background(AppColors.primaryMainGreen)
            .onAppear{
                gotoLoginScreen(time: 2.5)
            }
        
    }
    
    func gotoLoginScreen(time: Double) {
          DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
              let user = Auth.auth().currentUser
              print(user?.displayName)
               if(user == nil){
                   next(LoginFlowScreen.Welcome)
               }else{
                   next(LoginFlowScreen.MainApp)
               }
          }
      }
}


struct SplashPreView : PreviewProvider {
    static var previews : some View {
        SplashScreen(){_ in
            
        }
    }
}
