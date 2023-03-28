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
                print("matchCount = \(self.matchConnection.count)")
                self.matchConnection.append(contentsOf: result!)
                print("matchCount = \(self.matchConnection.count)")
            }
        }
    }
    
    func getChatGroupList(){
        
        chatApi.getchatGroupList{ result in
            print(result)
            if result != nil {
                result?.forEach({ ChatListItem in
                    print(ChatListItem.type)
                    print(ChatListItem.type?.rawValue)
               
                })
                self.chatGroupList.append(contentsOf: result!)
            }
        }
    }
    
}
