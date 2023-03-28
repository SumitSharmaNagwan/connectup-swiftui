//
//  ImageView.swift
//  BasicSwift
//
//  Created by remotestate on 22/03/23.
//


import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    var downloadedImage: UIImage?
    @Published var data: Data?
    
    func load(url: String) {
        
        var r = url
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.data = nil
                }
                return
            }
            
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
        
    }
    
    
}

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String?, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        if url != nil{
            self.imageLoader.load(url: url!)
        }
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage)
                .resizable()
        } else {
            return placeholder
        }
    }
    
}

struct ImagePreview : PreviewProvider {
   
    
    static var previews: some View{
        var url = "https://media.istockphoto.com/id/1346932521/photo/virtual-video-conference-business-meeting.jpg?b=1&s=170667a&w=0&k=20&c=CajphXYbFBefU2j8Q56SDVFd8YkBOD8eruR4pSrr5cM="
        
        URLImage(url: url)
        /*
        Image("user1")
            .load(stringUrl: url)
            .resizable()
            .aspectRatio( contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipped()
         */
      
          
        // Text("ggg")
    }
}

extension Image {
    func load(stringUrl : String?) -> Self {
        
        let url = URL(string: stringUrl ?? "")
        if url != nil{
            if let data = try? Data(contentsOf: url!){
                return Image(uiImage: UIImage(data: data)!)
            }
        }
        return self .resizable()
            
    }
    
    
    func loaddd(stringUrl : String?) -> Self {
        
        @ObservedObject  var imageLoader = ImageLoader()
        
       // var placeholder: Image
        
        if stringUrl != nil{
            imageLoader.load(url: stringUrl!)
        }
        
        let url = URL(string: stringUrl ?? "")
        if url != nil{
            if let data = try? Data(contentsOf: url!){
                return Image(uiImage: UIImage(data: data)!)
            }
        }
        return self .resizable()
            
    }
}
