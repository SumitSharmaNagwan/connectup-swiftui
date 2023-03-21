//
//  model.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation

struct MatchConnection : Decodable, Hashable {
      let currentPosition: String?
      let connectionId: Int
      let imageUrl: String?
      let name: String
      let userId: Int
      let chatGroupId:String?
      var isSelected :Bool? = false
}

struct LastMessageInfo : Decodable, Hashable{
    let lastMessageBy: String?
       let lastMessageSentAt: Date?
       let lastMessageText: String?
      // val lastMessageType: ChatMessageCategory?,
      // @PrimaryKey(autoGenerate = false)
       var chatId :String?
}

struct ChatListItem: Decodable, Hashable{
    let id: String
    let currentPosition: String?
      let imageUrl: String?
    //  @SerializedName("lastMessageInfo")
     // let lastMessageInfo: LastMessageInfo?
      let name: String
      let type: String
      let unreadCount: Int
      let archivedAt : Date?
      //@SerializedName("isBlocked")
     // val isChatGroupBlocked : Boolean,
    //  @SerializedName("isUserBlocked")
     // val isImBlocked : Boolean,
     // @SerializedName("isDeleted")
    //  val isUserAccountDeleted : Boolean,
     // @SerializedName("totalUsers")
      let totalUsers : Int
      // val isConnected : Boolean
}
