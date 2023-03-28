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

struct LastMessageInfo : Decodable, Hashable,Encodable{
    let lastMessageText: String?
    let lastMessageBy: String?
    let lastMessageByUserId: Int?
    var lastMessageSentAt: Date?
    let lastMessageType :String?
}


enum Grouptype : String ,Hashable, Codable{
    case  individual, group
    case unknown
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        // Try to initialize Self from value, if
        // value is not 1, 2, 3, or 4, initialize Self to
        // the unknown case.
        self = .init(rawValue: value) ?? .unknown
    }
}

struct ChatListItem: Decodable, Hashable{
    let id: String
    let currentPosition: String?
      let imageUrl: String?
    //  @SerializedName("lastMessageInfo")
    var lastMessageInfo : LastMessageInfo?
      let name: String
      let type: Grouptype?
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
