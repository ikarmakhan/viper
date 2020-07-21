//
//  RequestConverter.swift
//  Pace
//
//  Created by  on 17/12/2018.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation

public protocol RequestConvertible {
    var method: HTTPMethod {get set}
    var route: String {get set}
    var parameters: [String:Any]? {get set}
    var headers: RequestHeaders? { get set }
}

/// Converter object that will allow us to play nicely with Alamofire
public struct RequestConverter: RequestConvertible {
    
    public var method: HTTPMethod
    public var route: String
    public var parameters: [String:Any]?
    public var headers: RequestHeaders?
    public let encoding: String.Encoding?
    
    
    init(param:String? = nil,
         method:HTTPMethod,
         route:String,
         parameters:Parameters? = nil,
         headers:RequestHeaders? = [:],
         encoding:String.Encoding? = .utf8) {
        
        self.method = method
        self.route = route
        self.parameters = parameters
        self.encoding = encoding
        self.headers = getDefaultHeaders(headers:headers, timeStamp: nil)
    }
}

extension RequestConverter {
    
    func getDefaultHeaders(headers:RequestHeaders?,timeStamp:Double?) -> RequestHeaders {
        
        var requestHeaders: RequestHeaders = [:]
        requestHeaders["Content-Type"] = "application/json"
//        var token : String = ""
        guard let headers = headers else { return requestHeaders }
        requestHeaders.merge(dict: headers)
        return requestHeaders
    }
    
}

extension RequestConverter  {
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.basePath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(route))
        urlRequest.timeoutInterval = 60
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .returnCacheDataElseLoad
//        let parameter = parameters
//        if let _encoding = encoding {
//            return try _encoding.encode(urlRequest, with: parameter)
//        }
        return urlRequest
    }
}

