//
//  String+Extension.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

extension String {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkFailureReason.reason(error: "Invalid URL") }
        return url
    }

}
