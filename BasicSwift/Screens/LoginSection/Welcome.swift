//
//  Welcome.swift
//  BasicSwift
//
//  Created by remotestate on 15/03/23.
//

import Foundation
import SwiftUI

struct WelcomeScreen: View{
    var next : (LoginFlowScreen)->()
    var body: some View{
        VStack(alignment: .center){
            LoginAppBar()
            Spacer()
            Image("welcomeImage")
                .frame(width: .infinity)
                .padding(.bottom,40)
            
            Text("Connect with people move up in the world")
                .font(.system(size: 24,weight: Font.Weight.regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal,60)
                .padding(.bottom,52)
                
            PrimaryButton(label: "Login", action:{
                next(LoginFlowScreen.Login)
            }
                       , buttonColorSolid: ButtonColorSolid.Green )
            .padding(.horizontal,16)
            ButtonOutLook(label: "Register") {
                
            }
                      
            .padding(.horizontal,16)
            .padding(.top,16)
                
          
            
        }
        .frame(width: .infinity,height: .infinity)
        
    }
}

struct WelcomePreView: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(){_ in
            
        }
    }
}
