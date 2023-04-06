//
//  example.swift
//  BasicSwift
//
//  Created by remotestate on 30/03/23.
//

import Foundation
import SwiftUI
import Combine


class ApiService {
    @Published var basicPublisher: String = "1"
    let currentValueSubject = CurrentValueSubject< String, Never>("1")
    let passThroughValue = PassthroughSubject<String, Error>()
    
     func fetchData()  {
        let items = ["one", "two", "three", "four"]
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)){
                self.basicPublisher = items[i]
                self.passThroughValue.send(items[i])
            }
        }
    }
    
}

class CombineViewModel : ObservableObject {
    @Published var data : [String] = []
    let apiService = ApiService()
    var anyCancellable = Set<AnyCancellable>()
    init (){
        addSubscribe()
        apiService.fetchData()
    }
    
    func addSubscribe() {
        apiService.passThroughValue
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error) :
                    print(error.localizedDescription)
                    break
                    
                }
                
            } receiveValue: { [weak self] String in
                self?.data.append(String)
            }
            .store(in: &anyCancellable)
    }
    
    
}


struct CombineExView : View{
    @StateObject private var vm = CombineViewModel()
    var body: some View {
        VStack {
            ForEach(vm.data, id: \.self){ item in
                Text(item)
            }
            Spacer()
        }
    }
}

struct combineExPreview : PreviewProvider{
    static var previews: some View{
        CombineExView()
    }
}

