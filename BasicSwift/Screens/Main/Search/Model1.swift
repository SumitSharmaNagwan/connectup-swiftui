//
//  Model.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation

struct SearchUserModel: Decodable, Hashable{
    let currentPosition: String?
    let id: Int
    let isAlreadyConnected: Bool
    let isOnline: Bool
    var isVerified: Bool
    let name: String
    let profileImageUrl: String?
    func getPaddingForNmae() -> CGFloat{
        if isVerified {
            return 12.0
        }
        else{
            return 16.0
        }
    }
}
