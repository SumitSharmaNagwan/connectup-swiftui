//
//  Model.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation

struct SearchUserModel: Decodable{
    let currentPosition: String?
    let id: Int
    let isAlreadyConnected: Bool
    let isOnline: Bool
    let isVerified: Bool
    let name: String
    let profileImageUrl: String?
}
