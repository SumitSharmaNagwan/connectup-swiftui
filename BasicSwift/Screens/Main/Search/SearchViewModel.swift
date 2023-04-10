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
    @Published var canLoadMore = false
    @Published
     var curruntSearchTab = SearchTab.Newest
    @Published var searchText  = "" {
        didSet {
            print("did  \(searchText )")
        }
    }
    private var searchCallback  = Set<AnyCancellable>()
    @Published
    var loaderState = LoaderState()
    @Published var subscreen = ScreenSubView.Main
    @Published var errorStatus = ErrorStatus(errorType: nil, message: nil, error: nil, serverErrorResponse: nil)

    init(){
        $searchText.sink { String in
            print("init \(String)")
        }.store(in: &searchCallback)
        loadUser(isClearList: false)
    }
    
    func handleError(error : Subscribers.Completion<ErrorStatus>){
        loaderState.isHide()
        switch error {
        case .failure (let errorState) :
            print("")
        
        case.finished :
            print(" ")
        }
    }
    
    func loadUser(isClearList : Bool){
        if isClearList {
            loaderState.show()
        }
     
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
        recommendUserApi.searchUser(searchUserRequest: searchUserRequest)
            .sink {[weak self] error in
                self?.canLoadMore = false
                self?.handleError(error: error)
            } receiveValue: { [weak self] list in
                self?.loaderState.isHide()
                if limit == list.count{
                    self?.page += 1
                    self?.canLoadMore = true
                }else {
                    self?.canLoadMore = false
                }
                    DispatchQueue.main.async {
                    
                        self?.userList.append(contentsOf: list)
                    }
            }
            .store(in: &searchCallback)
    }
    
}


