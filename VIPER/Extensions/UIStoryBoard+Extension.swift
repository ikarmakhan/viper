//
//  UIStoryBoard+Extention.swift
//
//
//  Created by  on 26/03/2020.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import UIKit

 enum Storyboard:String {
    case Splash
    case Home
}

protocol Storyboardable: AnyObject { }

extension Storyboardable where Self: UIViewController {

    static func instantiate(withStoryBoard storyBoard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: Self.string) as? Self else {
             fatalError("Could not instantiate storyboard with name: \(storyBoard.rawValue)")
        }

        return vc
    }
}

extension UIViewController: Storyboardable { }
