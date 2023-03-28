//
//  HttpUtility.swift
//  BasicSwift
//
//  Created by remotestate on 17/03/23.
//

import Foundation
import FirebaseAuth
import Firebase

enum MethodType: String{
    case  post,get,put,delete
}
final class HttpUtility{
    static let shared = HttpUtility()
    private init(){}
    
    private func postData<T:Decodable>(request : URLRequest, resultType:T.Type, completionHandler: @escaping (_ result: T?)-> Void){
        
        DispatchQueue.main.async {
            
        URLSession.shared.dataTask(with: request){data, response, error in
            print(error)
            print(response)
            print("JSON String: \(String(data: data!, encoding: .utf8))")
            
            
            if(error == nil && data != nil){
                
                do{
                    var jsonDecoder = JSONDecoder()
                    let format = DateFormatter()
                    format.dateFormat =     "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    jsonDecoder.dateDecodingStrategy = .formatted(format)
                    let response =  try jsonDecoder.decode(resultType.self, from: data!)
                    
                    
                    completionHandler(response)
                }
                catch {
                    
                }
            }
            
        }.resume()
        
    }
    }
    
    func apiCall<ResultType: Decodable>(request: Encodable?, methodType: MethodType, endPoint : String, resultType: ResultType.Type , completionHandler: @escaping (_ result: ResultType?)-> Void , query : Array<URLQueryItem>? = nil){
        
        let url = Constant.BASE_URL_DEV + endPoint
        var urlComponent = URLComponents(string: url)
       if query != nil{
           urlComponent?.queryItems = query
        }
        
        var urlRequest = URLRequest(url: (urlComponent?.url!)!)
        
        urlRequest.httpMethod = methodType.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            currentUser?.getIDTokenResult(forcingRefresh: true, completion: { tokenResult, error in
                let token = tokenResult?.token
                print(tokenResult?.token)
                urlRequest.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
                var d = urlRequest.value(forHTTPHeaderField: "Authorization")
                // print("add token  \(d!)")
                print(urlRequest)
                if (request != nil ){
                    urlRequest.httpBody = try? JSONEncoder().encode(request!)
                }
                self.postData(request: urlRequest, resultType: resultType, completionHandler: completionHandler)
                
            })
        }else {
            print(urlRequest)
            if (request != nil ){
                urlRequest.httpBody = try? JSONEncoder().encode(request!)
            }
            self.postData(request: urlRequest, resultType: resultType, completionHandler: completionHandler)
        }
      
     //  getRefreshToken()
        
     
    }
    
    
 
            
        
        func getRefreshToken() {
          
            let currentUser = Auth.auth().currentUser
            
            currentUser?.getIDTokenResult(forcingRefresh: false, completion: { tokenResult, error in
                print(tokenResult?.token)
                
            })
        }
        
            
}
