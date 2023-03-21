//
//  SearchUserScreen.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//

import Foundation
import SwiftUI


enum SearchTab : String {
    case  Newest, Online, Verified
}

struct SearchScreen:View{
    @ObservedObject var searchViewModel = SearchViewModel()
   // @State
   // var currentTab = SearchTab.Online
    var body: some View{
        VStack(spacing: 0){
           
            
            HomeAppBar(title: "Search")
            SearchView(searchText: $searchViewModel.searchText)
                .padding(.horizontal,16)
                .padding(.top,16)
                .onReceive(searchViewModel.$searchText) { v in
                  
                    print(v)
                }
            
          
            Group{
                
                HStack(alignment: .firstTextBaseline){
                    Spacer()
                    SearchTabItem(currentTab: searchViewModel.curruntSearchTab, tabName: SearchTab.Newest)
                        .onTapGesture {
                            searchViewModel.curruntSearchTab = SearchTab.Newest
                            searchViewModel.page = 0
                            searchViewModel.loadUser(isClearList: true)

                        }
                        .frame(width: 100)
                    Spacer()
                    SearchTabItem(currentTab: searchViewModel.curruntSearchTab, tabName: SearchTab.Online)
                        .onTapGesture {
                            searchViewModel.curruntSearchTab = SearchTab.Online
                            searchViewModel.page = 0
                            searchViewModel.loadUser(isClearList: true)

                        }
                        .frame(width: 100)
                    Spacer()
                    SearchTabItem(currentTab: searchViewModel.curruntSearchTab, tabName: SearchTab.Verified)
                        .onTapGesture {
                            searchViewModel.curruntSearchTab = SearchTab.Verified
                            searchViewModel.page = 0
                            searchViewModel.loadUser(isClearList: true)

                        }
                        .frame(width: 100)
                    Spacer()
                }
                Divider()
                    .frame(width: .infinity, height: 1)
                    .background(AppColors.grayScaleGray2)
                    .offset(y:-1)
                    .zIndex(-8)
                
                // user list
                
                let data = (1...100).map { "Item \($0)" }

                   let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                   ]
                
                ScrollView{
                    LazyVGrid(columns: columns , spacing: 0){
                       
                        ForEach(searchViewModel.userList, id : \.self){ item in
                            
                            SearchViewItem(searchViewModel: item, isVerified: searchViewModel.curruntSearchTab.rawValue == SearchTab.Verified.rawValue)
                            
                        }
                    }
                }
                .frame(minHeight: 200,maxHeight: .infinity)
                                .padding(.horizontal,8)
                                
                
               
                
                
            }
            
            
            Spacer()
        }
    }
}

struct SearchTabItem : View {
    var currentTab : SearchTab
    var tabName : SearchTab
    var body: some View{
        if currentTab == tabName {
            VStack{
                Text(tabName.rawValue)
                    .font(.system(size: 16, weight: Font.Weight.bold))
                    .foregroundColor(AppColors.grayScaleBlack)
                    .padding(.top,24)
                Image("RectangleSearchTab")
                    .resizable()
                    .frame(width: 100,height: 4)
            }
        }else{
            Text(tabName.rawValue)
                .font(.system(size: 16, weight: Font.Weight.medium))
                .foregroundColor(AppColors.grayScaleGray4)
                .padding(.top,24)
        }
    }
    
}

struct SearchViewItem : View {
    var searchViewModel : SearchUserModel
    var isVerified = false
    var body: some View{
        VStack(spacing:0){
            /*
            AsyncImage(url: URL(string: searchViewModel.profileImageUrl ?? ""), content: { image in
               // image.resizable()
                
            },
                       placeholder: {
                ProgressView()
            }
            )
             */
            Image("user1")
                .resizable()
                .frame(width:80,height: 80)
                .clipShape(Circle())
                .padding(.top,18)
            if isVerified {
                Image("verifiedsolid")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .offset(y:-12)
                    .padding(.bottom,-12)
            }
          
            Text(searchViewModel.name)
                .font(.system(size: 14,weight: Font.Weight.bold))
                .padding(.top,searchViewModel.getPaddingForNmae())
                .foregroundColor(AppColors.grayScaleBlack)
            Text(searchViewModel.currentPosition ??  "")
                .font(.system(size: 12))
                .padding(.top,4)
                .foregroundColor(AppColors.grayScaleBlack)
                .padding(.bottom,18)
        }
        .cornerRadius(12)
        .frame(minWidth: 100,maxWidth: .infinity)
        .overlay{
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.grayScaleGray2, lineWidth: 1)
        }
        .padding(.horizontal,8)
        .padding(.top,16)
    }
}

struct SearchScreenPreview : PreviewProvider {
    static var previews: some View{
        Group{
            
            SearchScreen()
            let item = SearchUserModel(currentPosition: "String", id: 1, isAlreadyConnected: true, isOnline: true, isVerified: true, name: "Ram", profileImageUrl: "String")
            SearchViewItem(searchViewModel: item)
        }
    }
}
