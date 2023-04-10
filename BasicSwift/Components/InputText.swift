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

class VM : ObservableObject {
    @Published
    var propetites = InputTextPropetites()
    @Published
    var propetitesName = InputTextPropetites()
    init(propetites: InputTextPropetites = InputTextPropetites(), propetitesName: InputTextPropetites = InputTextPropetites()) {
        self.propetitesName = propetitesName
        self.propetitesName.startIcon = "profileIcon"
        self.propetitesName.placeHolder = "Name"
        self.propetites = propetites
        self.propetites.placeHolder = "Email"
        self.propetites.startIcon = "email"
        self.propetites.errorMessage = "Please enter email"
        self.propetitesName.errorMessage = "Please enter name"
        self.propetites.isError = true
        self.propetites.isPassword = true
    }
    
    func validate (){
        
    }
}



struct InputTextFieldPreView: PreviewProvider{
    @ObservedObject
    static var vm =  VM()
    static var previews: some View{
        Group{
           // FormView()
           // InputTextField(startIcon: "email",endIcon: "eye",placeHolder: "Name",text: .constant("Hello"))
            
           // SearchView(searchText: .constant(""))
            VStack{
               // InputTextFieldTest(properties: $vm.propetites)
               // InputTextFieldTest(properties: $vm.propetites)
                FormView()
            }
        }
    }
}


func Validate(properties : InputTextPropetites){
    
}





struct FormView : View {
   @ObservedObject
    var vm = VM()
    
    
    var body: some View {
        VStack {
            
           
            InputTextFieldTest(properties: $vm.propetitesName)
            InputTextFieldTest(properties: $vm.propetites)
            
            PrimaryButton(label: "Check") {
                vm.validate()
            }
            .padding(.top, 200)
        }
        .padding(.horizontal,20)
    }
}

class InputTextPropetites : ObservableObject {
    @Published
    var startIcon : String? = nil
    @Published
    var endIcon : String? = nil
    @Published
    var placeHolder : String? = nil
    @Published
    var text : String = ""
    @Published var errorMessage : String = ""
    @Published var isError : Bool = false
    @Published var isPassword : Bool = false
    
}


struct InputTextFieldTest: View {
    @Binding
    var properties : InputTextPropetites
    @FocusState var focused: Bool
    var padding = 16.0
    private let labelEmptyPaddingBottom = EdgeInsets(top: 0, leading: 65, bottom: 9, trailing: 0)
    private let labelPaddingBottom = EdgeInsets(top: 0, leading: 65, bottom: 48, trailing: 0)
    
    
    @State private var edges = EdgeInsets(top: 0, leading: 65, bottom: 9, trailing: 0)
    @StateObject private var vm = ViewModel()
    var body: some View{
        VStack {
        ZStack(alignment: .leading){
            VStack{
                Spacer()
                HStack{
                    if properties.startIcon != nil{
                        Image(properties.startIcon!)
                            .frame(width: 24,height: 24)
                            .padding(.horizontal,padding)
                    }
                    if properties.isPassword {
                        SecureField("", text: $properties.text)
                    }else {
                        TextField("", text: $properties.text)
                    }
                
                    if properties.endIcon != nil{
                        Image(properties.endIcon!)
                            .frame(width: 24,height: 24)
                            .padding(.horizontal,padding)
                    }
                    
                }
                Divider()
                    .padding(.horizontal,padding)
                    .padding(.top,12)
               
            }
            .frame(height: 56)
            
            Text(properties.placeHolder ?? "")
                .padding( properties.text.isEmpty ? labelEmptyPaddingBottom : labelPaddingBottom)
                .font(.system(size: 14,weight: Font.Weight.bold))
                .foregroundColor(AppColors.grayScaleGray4)
        }
        .onTapGesture {
            focused = true
        }
            if properties.isError {
                HStack{
                    Text(properties.errorMessage)
                        .foregroundColor(AppColors.alertsError)
                        .padding(.leading, 16)
                    
                    Spacer()
                }
            }
    }
    }
}
