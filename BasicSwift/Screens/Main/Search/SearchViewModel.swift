//
//  SearchViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 20/03/23.
//

import Foundation
import SwiftUI
import Combine

final class SearchViewModel : ObservableObject{
    @Published
    var userList = Array<SearchUserModel>()
    let recommendUserApi = RecommendationApi()
    var page = 0
    @Published
     var curruntSearchTab = SearchTab.Newest
    @Published var searchText  = "" {
        didSet {
            print("did  \(searchText )")
        }
    }
    private var searchCallback  = Set<AnyCancellable>()

    init(){
        $searchText.sink { String in
            print("init \(String)")
        }.store(in: &searchCallback)
        loadUser(isClearList: false)
    }
    
    func loadUser(isClearList : Bool){
        if isClearList {
            userList.removeAll()
        }
        print("\(searchText)     \(curruntSearchTab.rawValue)")
        let limit = 20
        let searchUserRequest = SearchUserRequest(
            onlineOnly: curruntSearchTab.rawValue == SearchTab.Online.rawValue,
            searchText: searchText,
            newest: curruntSearchTab.rawValue == SearchTab.Newest.rawValue,
            limit: limit,
            page: page
        )
        recommendUserApi.searchUser(searchUserRequest: searchUserRequest) { list in
            if limit == list?.count{
                self.page = self.page + 1
            }
            if list != nil {
                DispatchQueue.main.async {
                
                    self.userList.append(contentsOf: list!)
                }
               
            }
        
        }
    }
    
}


