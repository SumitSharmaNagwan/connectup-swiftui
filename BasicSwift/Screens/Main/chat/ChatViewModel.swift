//
//  ChatViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation

class ChatViewModel : ObservableObject {
    let chatApi = ChatApi()
    @Published
    var searchText = ""
    @Published
    var matchConnection = Array<MatchConnection>()
   @Published
    var chatGroupList = Array<ChatListItem>()
    
    func getMatchConnection(){
        
        chatApi.matchConnection( newMatchedOnly: true) { result in
            print(result)
            if result != nil {
                self.matchConnection.append(contentsOf: result!)
            }
        }
    }
    
    func getChatGroupList(){
        
        chatApi.getchatGroupList{ result in
            print(result)
            if result != nil {
                self.chatGroupList.append(contentsOf: result!)
            }
        }
    }
    
}
