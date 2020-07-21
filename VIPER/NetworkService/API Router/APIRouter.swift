//
//  APIRouter.swift
//  Pace
//
//  Created by  on 17/12/2018.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation


struct APIRouter:URLRouter {
    
    static var basePath: String {
        return C.BaseURL.path
    }
    
    struct getPopularMovies:Readable {
        var route: String = C.Endpoints.getPopularMovies
    }
    
    struct getTopRatedMovies : Readable {
        var route: String = C.Endpoints.getTopRatedMovies
    }
    
    struct getUpcomingMovies : Readable {
        var route: String = C.Endpoints.getUpcomingMovies
    }
    
    struct  getMovieDetails : Readable {
        var route: String = C.Endpoints.getMovieDetails
    }
    
}



