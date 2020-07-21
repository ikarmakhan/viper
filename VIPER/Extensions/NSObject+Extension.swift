//
//  Extentions.swift
//  
//
//  Created by  on 26/12/2018.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation


extension NSObject {
   class var string : String {
        get {
            return String(describing: self) // gives name of the class
        } set (key) {
            
        }
    }
    
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}




