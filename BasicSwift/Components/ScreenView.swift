//
//  ScreenView.swift
//  BasicSwift
//
//  Created by remotestate on 03/04/23.
//

import Foundation
import SwiftUI

enum ScreenSubView {
    case  Main, NerWorkError, InvalidInputPopup
}

class LoaderState : ObservableObject {
    @Published
     var state = false
    private var visibleCount  = 0
    func show(){
        visibleCount += 1
        state  = true
    }
    func isHide(){
        if visibleCount < 1{
            visibleCount = 0
        } else {
            visibleCount -= 1
        }
        if visibleCount == 0 {
            state = false
        }
    }
    
   // func state() -> Bool { return isShow }
}

struct ScreenView <Content: View>: View {
    @StateObject
    var loaderState : LoaderState
    @Binding
    var screenSubView : ScreenSubView
    @Binding var errorStatus : ErrorStatus
    @State var showAlert = false
    
    @ViewBuilder var content : Content
    var body : some View {
        ZStack{
         
                content
                    .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,  maxHeight: .infinity)
           
            if ScreenSubView.NerWorkError == screenSubView{
                NetWorkErrorView()
            }
            
            if ScreenSubView.InvalidInputPopup == screenSubView{
                
               
                
                DialogMessage(screenSubView: $screenSubView, title: "Invalid Input", message: errorStatus.message)
            }
          
            
            if loaderState.state {
                Loader(isShow: true)
            }
         
        }
    }
    
    
    
}

struct DialogMessage : View {
    @Binding
    var screenSubView : ScreenSubView
    let title : String
    let message : String?
    var body: some View{
        VStack {
            
            VStack(spacing: 8){
               
                Text(title)
                    .font(.system(size: 16, weight: Font.Weight.bold))
                   
                Divider()
                Text(message ?? " ")
                    .padding(.top,8)
               
                Button {
                    self.screenSubView = ScreenSubView.Main
                    
                } label: {
                    Text("OK")
                }
                .padding(.vertical,8)

            }
            .padding(8)
            .frame(width: 300)
            .background(AppColors.screenBackGround)
            .cornerRadius(10)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(AppColors.loaderBackground)
        
    }
}

struct NetWorkErrorView : View {
    var body: some View {
        VStack{
            Text("network error ")
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,  maxHeight: .infinity)
        .background(Color.orange)
    }
}


struct TestView : View {
    @State
    var isShowLoader = false
    @StateObject
    var loaderState = LoaderState()
   
    
    @State  var screen = ScreenSubView.InvalidInputPopup
    @State
    var errorStatus = ErrorStatus(errorType: nil, message: nil, error: nil, serverErrorResponse: nil)
    var body: some View {
        ScreenView(loaderState: loaderState , screenSubView: $screen, errorStatus: $errorStatus) {
            WelcomeScreen {_ in
                
            }
        }
      
    }
}

struct ScreenViewPreview : PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
