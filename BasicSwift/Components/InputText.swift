//
//  InputText.swift
//  BasicSwift
//
//  Created by remotestate on 15/03/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var text = ""
}



struct SearchView: View {

   @Binding var searchText : String
var body: some View {
    
    HStack{
        Image("Search")
        TextField("Search", text: $searchText)
    }
    .padding()
    .frame(width: .infinity,height: 48)
    .background(
        Capsule()
            .strokeBorder(AppColors.grayScaleGray2,lineWidth: 0.8)
            .clipped()
            .shadow(radius: 8)
    )
    .clipShape(Capsule())
    }
}

struct InputTextField: View {
    var startIcon : String? = nil
    var endIcon : String? = nil
    var placeHolder : String? = nil
    @Binding var text : String
    @FocusState var focused: Bool
    var padding = 16.0
    @State private var edges = EdgeInsets(top: 0, leading: 65, bottom: 9, trailing: 0)
    @StateObject private var vm = ViewModel()
    var body: some View{
        ZStack(alignment: .leading){
            VStack{
                Spacer()
                HStack{
                    if startIcon != nil{
                        Image(startIcon!)
                            .frame(width: 24,height: 24)
                            .padding(.horizontal,padding)
                    }
                    
                    TextField("", text: $text) { isEditing in
                            DispatchQueue.main.async {
                                if isEditing || !text.isEmpty {
                                    edges = EdgeInsets(top: 0, leading: 65, bottom: 48, trailing: 0)
                                }else{
                                    edges = EdgeInsets(top: 0, leading: 65, bottom: 9, trailing: 0)
                                }
                            }
                        }
                    .focused($focused, equals: true)
                    
                    
                    if endIcon != nil{
                        Image(endIcon!)
                            .frame(width: 24,height: 24)
                            .padding(.horizontal,padding)
                    }
                    
                }
                Divider()
                    .padding(.horizontal,padding)
                    .padding(.top,12)
            }
            .frame(height: 56)
            
            Text(placeHolder ?? "")
                .padding(edges)
                .font(.system(size: 14,weight: Font.Weight.bold))
                .foregroundColor(AppColors.grayScaleGray4)
        }
        .onTapGesture {
            focused = true
        }
       // .background(AppColors.grayScaleGray4)
    }
}


struct InputTextFieldPreView: PreviewProvider{
    static var previews: some View{
        Group{
            FormView()
            InputTextField(startIcon: "email",endIcon: "eye",placeHolder: "Name",text: .constant("Hello"))
            
            SearchView(searchText: .constant(""))
        }
    }
}





struct FormView : View {
    @State var text1 : String = ""
    @State var text2 : String = ""
    
    
    var body: some View {
        VStack {
            
            InputTextField(startIcon:"email", placeHolder: "Name", text: $text1)
            InputTextField(startIcon: "email",placeHolder: "Last name", text: $text2)
            
        }
        .padding(.horizontal,20)
    }
}
