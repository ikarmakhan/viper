//
//  OLAPIInterface.swift
//  Pace
//
//  Created by  on 7/19/17.
//

import Foundation

typealias CompletionSuccessHandler = (_ decodeable:Decodable?)->Void
typealias CompletionErrorHandler = (_ error:Error?)->Void
typealias CompletionHandler<T,E: Error> = (Result<T>) -> Void

enum Result<T> {
    case success(T?)
    case failure(NetworkFailureReason)
}

class OLAPIInterface: NSObject {
    
    static private let manager : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()
    
    static let sharedInstance = OLAPIInterface()
    
    override init() {
        super.init()
    }
    
    func request<T:Decodable>(_ request: URLRequest,
                              decodingType:T.Type?,
                              completion:@escaping (Result<T>) -> Void) {
        
        var request_ = request
        let urlString = request.url?.absoluteString.replacingOccurrences(of: "%3F", with: "?")
        request_.url = URL(string: urlString!)
        let task = URLSession.shared.dataTask(with: request_) { data, response_, error in
               guard let data = data,
                   let response = response_ as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                    if let err = error {
                        completion(.failure(NetworkFailureReason.responseFailed(error: err)))
                    }
                    return
               }
            
            do {
                if let type = decodingType {
                    let response = try JSONDecoder().decode(type, from: data)
                    completion(.success(response))
                }
                
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(NetworkFailureReason.decodingTypeFailed))
            }
            
           }
           task.resume()
        
        
//        guard let requestConvertible = request as? RequestConverter else {
//            completion(Result.failure(.invalidRequestConvertable))
//            return
//        }
        
        
//        OLAPIInterface.manager.dataTask(with: request) { (data, response, error) in
//
//        }
        
        
//        OLAPIInterface.manager.request(request).validate().responseJSON { [unowned self] (response) in
//            self.translateObject(request, decodingType: decodingType, response: response, completion: completion)
//
//        }
    }
    
//    private func translateObject<T:Decodable>(_ request: URLRequest,
//                                              decodingType:T.Type?,
//                                              response: URLResponse,
//                                              completion:@escaping (Result<T>) -> Void) {
//
//        //        print(response)
//        //        print(response.response?.statusCode ?? 0)
//
//
//
//        if response.result.error?._code == NSURLErrorTimedOut {
//            NotificationCenter.default.post(name: .requestTimeOut, object: self, userInfo: nil)
//            return
//        }
//
//        guard let _ = response.response else {
//            NotificationCenter.default.post(name: .serverNotfound, object: self, userInfo: nil)
//            return
//        }
//
//
//
//        switch response.result {
//            case .success(let r):
//
//            do {
//                guard let _ = decodingType else {return completion(Result.success(nil)) }
//
//                guard let decodingType = decodingType,let data = response.data  else { return completion(Result.failure(.decodingTypeFailed))}
//                if data == Data() { // To Check if data is of zero Bytes
//                    completion(.success(nil))
//                    return
//                }
//
//                let decodeableObj = try JSONDecoder().decode(decodingType, from: data)
//                completion(.success(decodeableObj))
//            } catch let error {
//                print(error)
//                completion(Result.failure(NetworkFailureReason.decodingFailed(error: error)))
//            }
//            break
//        case .failure(_) where response.response?.statusCode == 404 : // for page not found
//            NotificationCenter.default.post(name: .pageNotfound, object: self, userInfo: nil)
//            break
//        case .failure(_) where response.response?.statusCode == 403 : // for session out
//            NotificationCenter.default.post(name: .sessionOut, object: self, userInfo: nil)
//            break
//        case .failure(let error) where response.response?.statusCode == 401 : // for HawkAuthentication issue/Unautharized error
//            NotificationCenter.default.post(name: .sessionOut, object: self, userInfo: nil)
//            //            completion(Result.failure(NetworkFailureReason.responseFailed(error: error)))
//            break
//        case .failure( _) where (response.response?.statusCode ?? 0 >= 500 && response.response?.statusCode ?? 0 <= 600): // for internal server error
//            var userInfo : [String:Any]?
//            if let response_ = response.response, let requestId =  response_.allHeaderFields["x-request-id"]   {
//                userInfo = ["requestId":requestId]
//            }
//            NotificationCenter.default.post(name: .apiError, object: self, userInfo: userInfo)
//            break
//        case .failure(_) where response.response?.statusCode == 422:
//            do {
//                guard let _ = decodingType else {return completion(Result.failure(NetworkFailureReason.invalidRequestConvertable)) }
//
//                let decodeableObj = try JSONDecoder().decode(APIResponse.self, from: response.data!)
//                //completion(.success(decodeableObj))
//                completion(.failure(NetworkFailureReason.apiResponse(response: decodeableObj))) // For API errors e.g : Invalid Username and password comes with code 422
//            } catch (let error) {
//                completion(Result.failure(NetworkFailureReason.decodingFailed(error: error)))
//            }
//
//            break
//        case .failure(let error):
//            completion(Result.failure(NetworkFailureReason.responseFailed(error: error)))
//            break
//        }
//        default:
//        break
//    }
    
}

