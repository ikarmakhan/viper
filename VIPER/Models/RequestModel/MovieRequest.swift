//
//  MovieRequest.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

struct MovieRequest :  Codable {
    var type : Int?
    var page : Int?
    var language: String?
    
}
