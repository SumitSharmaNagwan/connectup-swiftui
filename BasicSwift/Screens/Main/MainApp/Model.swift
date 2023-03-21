//
//  Model.swift
//  BasicSwift
//
//  Created by remotestate on 20/03/23.
//

import Foundation

enum GenderType : Decodable {
    case  male, female, other,non_binary, none
}


struct MyProfileModel: Decodable {
    
    let id: Int
    let name: String
    let phone: String?
    let currentPosition: String?
    let email: String?
    let headline: String?
    //   @SerializedName("iAmLookingFor")
  //  let iAmLookingForIndustries: String?
    let about: String?
   // let profileImageId: Int?
   // let profileImageUrl: String?
   // let coverImageId: Int?
   // let coverImageUrl: String
   // let isEmailVerified: Bool
   // let isPhoneVerified: Bool
       //val selfInterestedIndustries: ArrayList<IndustriesListItem>,
  //  let gender: GenderType?
   // let dateOfBirth: Date
   // let inviteCode: String?
     //  @SerializedName("skipPhone")
   // let canSkipPhone: Bool = true
  //  var skipByUserAtFrontend: Bool = false
  //  let showSkipPhonePopup: Bool
  //  let showSkipPhonePopupAfterTime: Date?
       //val verificationFlows : VerificationFlowsStructure,
  //  let totalConnectionsCount : Int?
}
