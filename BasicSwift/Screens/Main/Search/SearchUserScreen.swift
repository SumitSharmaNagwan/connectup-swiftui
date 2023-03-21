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
    @State
    var currentTab = SearchTab.Online
    var body: some View{
        VStack(spacing: 0){
           
            HomeAppBar(title: "Search")
            SearchView()
                .padding(.horizontal,16)
                .padding(.top,16)
            
          
            Group{
                
                HStack(alignment: .firstTextBaseline){
                    Spacer()
                    SearchTabItem(currentTab: currentTab, tabName: SearchTab.Newest)
                        .onTapGesture {
                            currentTab = SearchTab.Newest
                        }
                        .frame(width: 100)
                    Spacer()
                    SearchTabItem(currentTab: currentTab, tabName: SearchTab.Online)
                        .onTapGesture {
                            currentTab = SearchTab.Online
                        }
                        .frame(width: 100)
                    Spacer()
                    SearchTabItem(currentTab: currentTab, tabName: SearchTab.Verified)
                        .onTapGesture {
                            currentTab = SearchTab.Verified
                        }
                        .frame(width: 100)
                    Spacer()
                }
                Divider()
                    .frame(width: .infinity, height: 1)
                    .background(AppColors.grayScaleGray2)
                    .offset(y:-1)
                    .zIndex(-8)
                
               
                
                
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

struct SearchScreenPreview : PreviewProvider {
    static var previews: some View{
        Group{
            SearchScreen()
        }
    }
}
