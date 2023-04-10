//
//  ChatViewModel.swift
//  BasicSwift
//
//  Created by remotestate on 21/03/23.
//

import Foundation
import Combine

class ChatViewModel : ObservableObject {
    let chatApi = ChatApi()
    @Published
    var searchText = ""
    @Published
    var matchConnection = Array<MatchConnection>()
   @Published
    var chatGroupList = Array<ChatListItem>()
    @Published var loaderState = LoaderState()
    @Published var screenSubView : ScreenSubView = ScreenSubView.Main
    @Published var errorStatus = ErrorStatus(errorType: nil, message: nil, error: nil, serverErrorResponse: nil)
    var disposeBag = Set<AnyCancellable>()
     
    deinit {
        print("chatListSize  deinit .....")
    }
    
    func getMatchConnection(){
        
        loaderState.show()
        chatApi.matchConnection( newMatchedOnly: true)
        
            .sink { [weak self] error in
                self?.errorHandling(completion: error)
            } receiveValue: { [weak self] list in
                self?.loaderState.isHide()
                self?.matchConnection.append(contentsOf: list)
            }
            .store(in: &disposeBag)

    }
    
    private func errorHandling(completion: Subscribers.Completion<ErrorStatus>) {
        loaderState.isHide()
        switch completion {
        case .failure(let error):
            print("error")
           
        case .finished:
            print("Publisher is finished")
        }
    }
    
    func getChatGroupList(){
        self.loaderState.show()
        chatApi.getchatGroupList()
            .sink { [weak self] error in
                
                self?.errorHandling(completion: error)
            } receiveValue: { [weak self] chatList in
                self?.loaderState.isHide()
               
                print("chatListSize 51 vm  \(self)")
            
                self?.chatGroupList.append(contentsOf: chatList)
             
            }
            .store(in: &disposeBag)
    }
    
}
