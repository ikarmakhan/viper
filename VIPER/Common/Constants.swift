//
//  Constants.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation
import UIKit

public enum PasswordError {
    case length
    case mismatch
    case format
    case empty
    case blank
    case none
}

struct C {

    public static var isSmallIphone : Bool {
        get{
            return UIScreen.main.bounds.height <= 568
        }
    }
    
    struct Configurations {
        #if DEBUG
        static let apiKey = "94e69be831fa502dbdac8204940f4a87"
        #else
        static let apiKey = "94e69be831fa502dbdac8204940f4a87"
        #endif
    }
    
    struct BaseURL {
        #if DEBUG
        static let path = "https://api.themoviedb.org/3"
        #else
        static let path = "https://api.themoviedb.org/3"
        #endif
    }
    
    struct Endpoints {
        static let getPopularMovies = "movie/popular?page=%ld&language=%@"
        static let getTopRatedMovies = "movie/top_rated?page=%ld&language=%@"
        static let getUpcomingMovies = "movie/upcoming?page=%ld&language=%@"
        
        static let getMovieDetails = "movie/%ld?language=%@"
    }
    
}

extension Notification.Name {

    static let sessionOut = Notification.Name("sessionOut")
    static let internalServerError = Notification.Name("internalServerError")
    static let inAppAlert = Notification.Name("inAppAlert")
    static let splash = Notification.Name("splash")
    static let pageNotfound = Notification.Name("pageNotfound")
    static let apiError = Notification.Name("apiError")
    static let serverNotfound = Notification.Name("serverNotfound")
    static let requestTimeOut = Notification.Name("requestTimeOut")
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

// MARK: -

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]
