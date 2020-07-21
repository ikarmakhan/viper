//
//  UILabel+Extention.swift
//  
//
//  Created by  on 21/12/2018.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit


extension UILabel {
   @IBInspectable var localizedText: String {
        set (key) {
            text = NSLocalizedString(key, comment: "")
        }
        get {
            return text!
        }
    }
}

extension UIButton {
    @IBInspectable var localizedText: String? {
        get { return nil }
        set(key) {
            guard let key = key else {return}
            setTitle(NSLocalizedString((key), comment: ""), for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable var localizedText: String? {
        get { return nil }
        set(key) {
            guard let key = key else {return}
            placeholder = NSLocalizedString(key, comment: "")
        }
    }
}

extension String {
    
    var localize : String {
        get {
           return NSLocalizedString(self, comment: "")
        }
        set (key) {
            
        }
    }
}

