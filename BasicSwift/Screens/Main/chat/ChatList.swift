//
//  Chat.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//

import Foundation
import SwiftUI

struct ChatListScreen:View{
    @ObservedObject
    var viewModel = ChatViewModel()
    var body: some View{
        ZStack{
            VStack(spacing: 0){
                HomeAppBar(title: "Chat")
                ScrollView{
                    SearchView(searchText: $viewModel.searchText)
                        .padding(.top,16)
                        .padding(.horizontal,16)
                    
                    Text("New Matchs")
                        .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(AppColors.grayScaleGray4)
                        .padding(.top,24)
                        .padding(.horizontal,16)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing:0){
                            ForEach(viewModel.matchConnection, id: \.self){ item in
                                MatchConnectionView(data: item)
                                    .padding(.leading,16)
                            }
                        }
                        
                    }
                    
                    Text("Messages")
                        .foregroundColor(AppColors.grayScaleGray4)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,16)
                        .font(.system(size: 14,weight: Font.Weight.semibold))
                    
                    
                    LazyVStack(spacing:0){
                        ForEach(viewModel.chatGroupList,id: \.self){ item in
                            ChatListItemView(data: item)
                        }
                        
                        
                    }
                    
                    
                    
                    
                    Spacer()
                }
            }
            
         
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("plusIcon")
                        .resizable()
                        .frame(width: 48,height: 48)
                        .padding(16)
                }
            }
        }
        .onAppear{
            viewModel.getMatchConnection()
            viewModel.getChatGroupList()
            
        }
    }
}


struct MatchConnectionView : View{
    var data : MatchConnection
    var body: some View{
        VStack(spacing: 0){
            Image("user1")
                .padding(.top,16)
            Text(data.name)
                .foregroundColor(AppColors.grayScaleBlack)
                .font(.system(size: 14,weight: .bold))
                .padding(.top,16)
            
            
            Text(data.currentPosition ?? "")
                .foregroundColor(AppColors.grayScaleBlack)
                .font(.system(size: 12,weight: .light))
                .padding(.top,4)
                .padding(.bottom,12)
            
        }
        .frame(width: 132)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.grayScaleGray2, lineWidth: 1)
        }
    }
}

struct ChatListItemView: View {
    var data : ChatListItem
    var body: some View{
        VStack(spacing: 0){
            HStack(spacing:0){
                Image("user1")
                    .resizable()
                    .frame(width: 48,height: 48)
                    .padding(.leading,16)
                VStack(alignment: .leading){
                    Text(data.name)
                        .font(.system(size: 14,weight: Font.Weight.semibold))
                        .foregroundColor(AppColors.grayScaleBlack)
                  
                    Text("Lorem ipsum dolor et sum netsu")
                        .font(.system(size: 12,weight: Font.Weight.semibold))
                        .foregroundColor(AppColors.grayScaleBlack)
                        
                }.padding(.leading,12)
                
                
                Spacer()
                
                Text("01:47 PM")
                    .font(.system(size: 12,weight: Font.Weight.semibold))
                    .foregroundColor(AppColors.grayScaleBlack)
                    .padding(.trailing,16)
            }
            .padding(.vertical,12)
            Divider()
                .frame()
        }
    }
}

struct ChatListScreenPreview : PreviewProvider {
    static var previews: some View{
        Group{
            ChatListScreen()
            MatchConnectionView(data: MatchConnection(currentPosition: "ios", connectionId: 0, imageUrl: "String", name: "Sunil", userId: 2, chatGroupId: "String"))
            
            ChatListItemView(data: ChatListItem(id: "String", currentPosition: "ios", imageUrl: "String", name: "Ram", type: "String", unreadCount: 1, archivedAt: nil, totalUsers: 1))
        }
    }
}
