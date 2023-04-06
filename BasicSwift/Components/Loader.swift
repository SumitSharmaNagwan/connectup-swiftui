//
//  Loader.swift
//  BasicSwift
//
//  Created by remotestate on 31/03/23.
//

import Foundation
import SwiftUI
import Combine

class LoaderEventResourse {
    private var isShowLoader = false
    let passThroughEvent = PassthroughSubject<String, Error>()
    
    let passThroughValue = PassthroughSubject<String, Error>()
    
     func fetchData()  {
        let items = ["one", "two", "three", "four"]
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)){
            
                self.passThroughValue.send(items[i])
            }
        }
    }
    
    
    private func load(){
        let delay  = 0.12
        let items = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
        for item in items.indices {
                    DispatchQueue.main.asyncAfter(deadline:.now() + Double( Double(item) * delay)){
                        self.passThroughEvent.send("cp_logo_\(item)")
                        
                    }

                }
    }
    
    func showLoader (){
        isShowLoader = true
        load()
        fetchData()
    }
    
    func hindeLoader(){
        isShowLoader = false
    }
    
}

class LoaderViewModel : ObservableObject {
    private var count = 0
    @Published
    var currentImage = "cp_logo_0"
    static let shared = LoaderViewModel()
    private var anyCancellable = Set<AnyCancellable>()
    private init(){
        show()
    }
    private var loaderEvent = LoaderEventResourse()
    
    
    
    func update(){
        if count == 21 {
            count = 0
        }else {
            count += 1
        }
        currentImage = "cp_logo_\(count)"
    }
    func show(){
       
        
        loaderEvent.passThroughEvent
        
            //.subscribe(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error) :
                    print(error.localizedDescription)
                    break
                    
                }
                
            } receiveValue: { String in
               // self.currentImage = String
            }
            .store(in: &anyCancellable)

        loaderEvent.showLoader()
    }
    
    func hide(){
        
        loaderEvent.hindeLoader()
    }
    
}

class MyTimer {
    let currentTimePublisher = Timer.TimerPublisher(interval: 0.12, runLoop: .main, mode: .default)
    let cancellable: AnyCancellable?

    init() {
        self.cancellable = currentTimePublisher.connect() as? AnyCancellable
    }

    deinit {
        self.cancellable?.cancel()
    }
}


struct Loader : View {
    @State var isShow : Bool
    private let timer = MyTimer()
      @StateObject
    private var vm = LoaderViewModel.shared
    
    @State
     var ci : String = "cp_logo_0"
    var body: some View{
        
        VStack{
            
            Image(vm.currentImage)
                .onReceive(timer.currentTimePublisher) { data in
                    if isShow {
                        vm.update()
                        print("update loader ...................")
                    }
                }
            
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0, maxHeight: .infinity)
        .background(AppColors.loaderBackground)
    }
}


struct LoadterTest: View {
    @State
    var isShow = false
    var body: some View{
        ZStack {
           // SplashScreen(next: {_ in })
            Loader(isShow: isShow)
        }
    }
}


struct LoaderPreview : PreviewProvider{
    static var previews: some View {
        LoadterTest()
    }
}
