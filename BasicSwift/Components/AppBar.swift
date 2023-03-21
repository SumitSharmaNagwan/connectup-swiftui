//
//  AppBar.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import SwiftUI
struct LoginAppBar: View {
    var body: some View{

        HStack{
            Spacer()
            Image("connectupHeader")
                .frame(width: 134,height: 24)
            Spacer()
        }
        .frame(height: 52)
        .background(AppColors.primaryMainGreen)
    }
}


struct HomeAppBar: View {
    var title : String
    var body: some View{
        
        ZStack{
            HStack{
                
                Image("appBarLogo")
                    .frame(width: 24,height: 24)
                    .padding(.leading,16)
                Spacer()
             Image("notification")
                    .padding(.trailing,10)
            }
            .frame(height: 52)
            .background(AppColors.primaryMainGreen)
            Text(title)
                .font(.system(size: 16,weight: Font.Weight.bold))
            
            
            
        }
     
    }
}

struct AppBarProvider : PreviewProvider{
    static var previews: some View{
        Group{
           // HomeAppBar(title: "Home")
           LoginAppBar()
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
