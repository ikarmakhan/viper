//
//  MovieDetailsInteractor.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

protocol MovieDetailsInteractorModeling : class {
    
    func fetchMovieDetails(movieId:Int)
    
    typealias onErrorAlias = (String) -> ()
    var onError : onErrorAlias? {get set}
    
    typealias receivedDetailsAlias = (MovieDetails?) -> ()
    var receivedDetails : receivedDetailsAlias? {get set}
}

class MovieDetailsInteractor : MovieDetailsInteractorModeling {
    
    var onError: MovieDetailsInteractorModeling.onErrorAlias?
    var receivedDetails: MovieDetailsInteractorModeling.receivedDetailsAlias?
    
    func fetchMovieDetails(movieId:Int) {
        MovieService().fetchMovieDetails(request: MovieDetailsRequest(movieId: movieId, language: "en-US")) {[weak self] (result) in
            switch result {
            case .success(let response):
                if let details = response {
                    self?.receivedDetails?(response)
                }
                break
            case .failure(let reason):
                self?.onError?(reason.localizedDescription)
            }
        }
    }
    
}
