//
//  Buttons.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//


import Foundation
import SwiftUI

struct PrimaryButton : View {
    @State var label : String
    var action : ()->()
    @State
    var isDisable  = false
    var buttonColorSolid : ButtonColorSolid = ButtonColorSolid.Green
    var body: some View {
            Button(label) {
               action()
            }
            .buttonStyle(PrimaryButtonStyleSolid(isDisable: isDisable,buttonColorSolid: buttonColorSolid))
          
            .disabled(isDisable)
        }
    

}


struct ButtonOutLook : View {
  
    @State var label : String
    var action : ()->()
    @State
    var isDiable  = false
    var body: some View {
        
        Button(action: {
            action()
        }){
          
            Text(label)
        }
       
        .buttonStyle(SecondaryButtonStyle(isDisable: isDiable))
       
    }
}
struct Test : View{
    var body: some View{
        VStack{
            Text("tesdsdfsdfsdfs").frame(width: .infinity)
            Spacer()
            Text("fsdsf")
            Button {
                print("Test \(Date())")
                print("click")
            } label: {
                Text("some button")
                             .padding(12)
                             .background(in: RoundedRectangle(cornerRadius: 24))
                             .backgroundStyle(AppColors.primaryMainGreen)
                            
            }
            
            .buttonStyle(.plain)
            

            Spacer()
           
        }.frame(width: .infinity,height: .infinity)
            .background(Color.gray)
    }
}



struct AllButtonView : View {
    var diasble = false
    var body: some View {
        VStack {
        
            PrimaryButton(label: "Hello", action: {
                
            } ,isDisable: diasble, buttonColorSolid: ButtonColorSolid.Green)
                
            PrimaryButton(label: "Hello", action: {
                
            } ,isDisable: diasble, buttonColorSolid: ButtonColorSolid.Black)
            
            PrimaryButton(label: "Hello", action: {
                
            } ,isDisable: diasble, buttonColorSolid: ButtonColorSolid.Red)
            
            PrimaryButton(label: "Hello", action: {
                
            } ,isDisable: diasble, buttonColorSolid: ButtonColorSolid.White)
        
        }
        .background(Color.blue)
    }
}

struct ButtonProvider : PreviewProvider{
    static var previews: some View{
        Group{
            
           AllButtonView()
            ButtonOutLook(label: "gddfd") {
                
            }

            // Test()
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
