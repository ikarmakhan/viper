//
//  APIRouter.swift
//  Pace
//
//  Created by  on 17/12/2018.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation

public typealias RequestHeaders = [String: String]

//struct CustomEncoding: ParameterEncoding {
//    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var request = try! URLEncoding().encode(urlRequest, with: parameters)
//        let urlString = request.url?.absoluteString.replacingOccurrences(of: "%3F", with: "?")
//        request.url = URL(string: urlString!)
//        return request
//    }
//}


protocol URLRouter {
    static var basePath: String { get }
    
}

protocol Routable {
    typealias Parameters = [String : Any] // whats its use ?
    var route: String {get set}
    init()
}

protocol Readable: Routable {}

extension Routable {
    /// Create instance of Object that conforms to Routable
    init() {
        self.init()
    }
}

extension Readable where Self: Routable {
    // FIXME : if rout path has appended paarams then provide a parameter in get, create etc to initialize it with that route else default
    static func get(editedPath:String? = nil,param:String? = nil,parameters: Parameters? = nil,headers: RequestHeaders? = nil) -> URLRequest {
        
        let router = Self.init()
        var routePath = router.route + "&api_key=\(C.Configurations.apiKey)"
        if let param = param {
            routePath = "\(router.route)/\(param)"
        }
        if let path = editedPath {
            routePath = path
        }
        
        do {
            let request  = try RequestConverter(param: nil,
            method: .get,
            route: routePath,
            parameters: parameters,
            headers: headers,
            encoding: .utf8).asURLRequest()
            
            return request
            
        } catch let error {
            print(error.localizedDescription)
            return URLRequest(url: URL(string: routePath)!)
        }
    }
    
    static func getQueryParams(editedPath:String? = nil,queryParams:Parameters? = nil,parameters: [String:String]? = nil,headers: RequestHeaders? = nil) -> RequestConverter {
        
        let router = Self.init()
        var routePath = router.route

        if let path = editedPath {
            routePath = path + "&api_key=\(C.Configurations.apiKey)"
        }
        // Custom encoding is given becasue edited path includes ? which in turn converts to %3F which do not works in request
        return RequestConverter(method: .get,
                                route: routePath,
                                parameters: parameters,
                                headers: headers,
            encoding: .utf8)
    }
}

