//
//  MovieService.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

class MovieService : NSObject {
    
    func fetchMoviesList (request : MovieRequest, completion:@escaping(Result<MoviesList>) -> Void) {
        var router : RequestConverter?
        var path : String?
        guard let page = request.page, let language = request.language, let typeV = request.type, let type = MovieListType.init(rawValue: typeV) else {
            completion(.failure(NetworkFailureReason.invalidRequestConvertable))
            return
        }
        
        switch type {
        case .Popular:
            path = String(format: C.Endpoints.getPopularMovies, page,language)
            router = APIRouter.getPopularMovies.getQueryParams(editedPath: path)
        case .TopRated:
            path = String(format: C.Endpoints.getTopRatedMovies, page,language)
            router = APIRouter.getTopRatedMovies.getQueryParams(editedPath: path)
        case .Upcoming:
            path = String(format: C.Endpoints.getUpcomingMovies, page,language)
            router = APIRouter.getUpcomingMovies.getQueryParams(editedPath: path)
//        default:
//            break
        }
        
        if let router = router {
            do {
                let routerRequest  = try router.asURLRequest()
                OLAPIInterface.sharedInstance.request(routerRequest, decodingType: MoviesList.self, completion: completion)
                return
                
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(NetworkFailureReason.invalidRequestConvertable))
            }
        }
        else {
            completion(.failure(NetworkFailureReason.invalidRequestConvertable))
        }
        
    }
    
    func fetchMovieDetails(request:MovieDetailsRequest, completion:@escaping(Result<MovieDetails>) -> Void) {
        if let movieId = request.movieId {
            
            let path = String(format: C.Endpoints.getMovieDetails, movieId, request.language ?? "en-US")
            let router = APIRouter.getMovieDetails.getQueryParams(editedPath:path)
            do {
                let routerRequest  = try router.asURLRequest()
                OLAPIInterface.sharedInstance.request(routerRequest, decodingType: MovieDetails.self, completion: completion)
                return
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(NetworkFailureReason.invalidRequestConvertable))
                return
            }
        }
        completion(.failure(NetworkFailureReason.invalidRequestConvertable))
    }
}
