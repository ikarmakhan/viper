//
//  Dictionary+Extention.swift
//  
//
//  Created by  on 15/04/2020.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation

extension Dictionary { // To merger headers above
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
