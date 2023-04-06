//
//  HttpUtility.swift
//  BasicSwift
//
//  Created by remotestate on 17/03/23.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine



enum ErroType {
    case ServerError, NetworkError, ServiceNotAvailiable, Unauthorized, ClientError, UnknownError, NoneOfThese, BadRequest, RequestTimeout, Redirection, PageNotFound
}

struct ErrorStatus : Error {
    let errorType : ErroType?
    let message : String?
    let error : Error?
    let serverErrorResponse : ServerErrorResponse?
    
}

struct ServerErrorResponse : Codable {
    let id, messageToUser, developerInfo, error: String?
    let statusCode: Int?
    let isClientError: Bool?
}

enum NetworkStatus {
   case Loading, Success, Error
}

class Resourse <T>{
    var status : NetworkStatus? = nil
    var data : T? = nil
    var error : ErrorStatus? = nil
    func loading () -> Resourse<T>{
        status = NetworkStatus.Loading
        return self
    }
    func success(apiData: T)-> Resourse<T> {
        data = apiData
        status = .Success
        return self
    }
    func error(errorStatus :ErrorStatus?) -> Resourse<T> {
        status = .Error
        error = errorStatus
        return self
    }
}

enum MethodType: String{
    case  post,get,put,delete
}
final class HttpUtility{
    static let shared = HttpUtility()
    private init(){}
    
    private func postData<T:Decodable>(request : URLRequest, resultType:T.Type, completionHandler: @escaping (_ result: Resourse<T>?)-> Void){
        var jsonDecoder = JSONDecoder()
        let format = DateFormatter()
        format.dateFormat =     "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        jsonDecoder.dateDecodingStrategy = .formatted(format)
        
        completionHandler(Resourse().loading())
        URLSession.shared.dataTaskPublisher(for: request)
        
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main )
        
            .tryMap{ (data, response) -> Data in
                
                
                print(response)
               let d =  (String(data: data, encoding: .utf8)!)
                print("JSON String: \(String(data: data, encoding: .utf8)!)")
                let response = response as? HTTPURLResponse
                guard
                    let response = response,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    
                    let serverErrorResponse = try jsonDecoder.decode(ServerErrorResponse.self, from: data)
                
                    var errorType = ErroType.UnknownError
                    let x = response?.statusCode ?? -1
                    switch x {
                    case let x where x >= 300 && x < 400 :
                        errorType = ErroType.Redirection
                        break
                    case 400 :
                        errorType = ErroType.BadRequest
                        break
                        
                    case 401 :
                        errorType = ErroType.Unauthorized
                        break
                        
                    case 404 :
                        errorType = ErroType.PageNotFound
                        break
                        
                    case 408 :
                        errorType = ErroType.RequestTimeout
                        break
                    case let x  where x > 401 && x < 500 :
                        errorType = ErroType.ClientError
                        
                    case let x  where x >= 500 && x < 600 :
                        errorType = ErroType.ServerError
                        
                    default:
                        print("error is not detected")
                    }
               
                    
                    var errorStatus = ErrorStatus(errorType: errorType, message: "\(serverErrorResponse.messageToUser!)", error: nil, serverErrorResponse : serverErrorResponse )
                    completionHandler(Resourse().error(errorStatus: errorStatus))
                    throw URLError(.badServerResponse)
                }
            
                return data
            }
            .decode(type: resultType.self, decoder: jsonDecoder)
            .sink { _ in
                
            } receiveValue: { (data) in
                completionHandler(Resourse().success(apiData: data))
            }
    
    }
    
    func apiCall<ResultType: Decodable>(request: Encodable?, methodType: MethodType, endPoint : String, resultType: ResultType.Type , completionHandler: @escaping (_ result: Resourse<ResultType>? )-> Void , query : Array<URLQueryItem>? = nil){
        
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
      
     //   getRefreshToken()
        
     
    }
    
    
    ////////////////////////////////////
    ///
    ///
    ///
    ///
    ///
    
    private func postData<T:Decodable>(request : URLRequest, resultType:T.Type,  passThroughSubject : PassthroughSubject<T, ErrorStatus> ) {
       
        var jsonDecoder = JSONDecoder()
        let format = DateFormatter()
        format.dateFormat =     "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        jsonDecoder.dateDecodingStrategy = .formatted(format)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main )
            .tryMap{ (data, response) -> Data in
                print(response)
               let d =  (String(data: data, encoding: .utf8)!)
                print("JSON String: \(String(data: data, encoding: .utf8)!)")
                let response = response as? HTTPURLResponse
                guard
                    let response = response,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    let serverErrorResponse = try jsonDecoder.decode(ServerErrorResponse.self, from: data)
                    var errorType = ErroType.UnknownError
                    let x = response?.statusCode ?? -1
                    switch x {
                    case let x where x >= 300 && x < 400 :
                        errorType = ErroType.Redirection
                        break
                    case 400 :
                        errorType = ErroType.BadRequest
                        break
                    case 401 :
                        errorType = ErroType.Unauthorized
                        break
                    case 404 :
                        errorType = ErroType.PageNotFound
                        break
                    case 408 :
                        errorType = ErroType.RequestTimeout
                        break
                    case let x  where x > 401 && x < 500 :
                        errorType = ErroType.ClientError
                    case let x  where x >= 500 && x < 600 :
                        errorType = ErroType.ServerError
                    default:
                        print("error is not detected")
                    }
        
                    var errorStatus = ErrorStatus(errorType: errorType, message: "\(serverErrorResponse.messageToUser!)", error: nil, serverErrorResponse : serverErrorResponse )
                    passThroughSubject.send(completion: .failure( errorStatus))
                    throw URLError(.badServerResponse)
                }
            
                return data
            }
            .decode(type: resultType.self, decoder: jsonDecoder)
            .sink { _ in
                
            } receiveValue: { (data) in
                passThroughSubject.send(data)
            }
        
       // return passThroughSubject
    
    }
    
    func apiCall<ResultType: Decodable>(request: Encodable?, methodType: MethodType, endPoint : String, resultType: ResultType.Type, query : Array<URLQueryItem>? = nil) -> PassthroughSubject<ResultType,ErrorStatus> {
        var  passThroughSubject = PassthroughSubject<ResultType, ErrorStatus> ()
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
               self.postData(request: urlRequest, resultType: resultType, passThroughSubject: passThroughSubject )
                
            })
        }else {
            print(urlRequest)
            if (request != nil ){
                urlRequest.httpBody = try? JSONEncoder().encode(request!)
            }
            self.postData(request: urlRequest, resultType: resultType, passThroughSubject: passThroughSubject)
        }
      
     //  getRefreshToken()
        
     return passThroughSubject
    }
            
        
        func getRefreshToken() {
          
           // let group = DispatchGroup()
            
            print("getRefreshToken call start")
            
            let currentUser = Auth.auth().currentUser
           // group.enter()
           
                currentUser?.getIDTokenResult(forcingRefresh: false, completion: { tokenResult, error in
                    print(tokenResult?.token)
                    print("getRefreshToken call result \(tokenResult?.token)")
                   // group.leave()
                })
        
           // group.wait()
            print("getRefreshToken call end")
        }
        
            
}
