//
//  APIResponse.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

struct APIResponse : Decodable {
    let error: String?
    let success : SucessResponse?
    let message : String?
    let status : Bool
    
    private enum CodingKeys:String,CodingKey {
        case error
        case success = "SUCCESS"
        case message
        case status
    }
    
}

struct SucessResponse : Decodable {
    var error:String?
    var status : String?
    var message : String?
    
    
    private enum CodingKeys:String,CodingKey {
        case error
        case status
        case message
    }
}
