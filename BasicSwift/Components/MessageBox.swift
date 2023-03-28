//
//  MessageBox.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import Foundation
import SwiftUI

struct MessageBox{
    var body: some View{
        HStack(alignment: .firstTextBaseline){
            Text("Top View")
            VStack(alignment: .leading){
                Text("Hello")
                    .font(.title)
                    .foregroundColor(.white)
                Text("This is subtitle ")
                
                    .padding(20)
            }
            .frame(height: 100)
            .background(Color.green)
            Spacer()
            VStack(alignment: .center){
                Text("Text1")
                Text("Text2")
            }
            .frame(height: 100)
            .background(Color.green)
        }.padding()
    }
}
/*

struct ImageView :View{
    var body: some View{
       
        VStack{
            HStack(){
                Text("start")
                Spacer()
                Text("end")
            }
            .frame(height: 300)
            .background(.green)
            
            Image("Image")
                .frame(width:100,height: 100)
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.white, lineWidth: 2)
                }
                .shadow(radius: 8)
                .offset(y:-50)
                .padding(.bottom, -50)
             Text("gddds")
        }
    }
}

*/

struct MessageBox_PreView: PreviewProvider {
   static var previews : some View {
      // MessageBox().body
       Text("ggg")    }
}
