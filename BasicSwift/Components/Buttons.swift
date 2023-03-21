//
//  Buttons.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//


import Foundation
import SwiftUI

enum ButtonState{
    case Default, Preesed,Disable
}

struct ButtonSolidGreen : View {
    @State private var state : ButtonState = ButtonState.Default
    @State var label : String
    var action : ()->()
    var body: some View{

        
        Button(action: {
            action()
        }){
           Spacer()
            Text(label)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
               // .frame(width: .infinity)
               // .onTapGesture {print("tap gesture")}
            
            Spacer()
    
        }
        .frame(width: .infinity ,height: 48)
        .buttonStyle(.plain)
        .background(in: RoundedRectangle(cornerRadius: 24))
        .backgroundStyle(getButtonColor(state: state))
    }
}


struct ButtonOutLook : View {
    @State private var state : ButtonState = ButtonState.Default
    @State var label : String
    var action : ()->()
    var body: some View{

        
        Button(action: {
            action()
        }){
           Spacer()
            Text(label)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
             
            
            Spacer()
    
        }
        .frame(width: .infinity ,height: 48)
        .buttonStyle(.plain)
        .backgroundStyle(getButtonColor(state: state))
        .overlay{
            RoundedRectangle(cornerRadius: 24)
                .stroke(AppColors.grayScaleSoftBlack,lineWidth: 1)
        }
        
    }
}
struct Test : View{
    var body: some View{
        VStack{
            Text("tesdsdfsdfsdfs").frame(width: .infinity)
            Spacer()
            Text("fsdsf")
            Button {
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

func getButtonColor(state : ButtonState) -> Color{
    return AppColors.primaryMainGreen
}

struct ButtonProvider : PreviewProvider{
    static var previews: some View{
        Group{
            
            ButtonSolidGreen(label: "Button"){
                
            }
            ButtonOutLook(label: "gddfd") {
                
            }

            // Test()
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
