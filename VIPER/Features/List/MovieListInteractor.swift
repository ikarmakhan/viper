//
//  MovieListInteractor.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

protocol MovieListInteractorModeling : class {
    func fetchMovies(type:MovieListType)
    
    typealias onErrorAlias = (String) -> ()
    var onError : onErrorAlias? {get set}
    
    typealias receivedListAlias = (MoviesList?) -> ()
    var receivedList : receivedListAlias? {get set}
    
}


class MovieListInteractor : MovieListInteractorModeling {
    
    var listPresenter : MovieListPresenterModeling! {
        didSet {
            
        }
    }
    
    var onError: MovieListInteractorModeling.onErrorAlias?
    var receivedList: MovieListInteractorModeling.receivedListAlias?
    
    private var currentPagePopular : Int = 1
    private var currentPageTopRated : Int = 1
    private var currentPageUpcoming : Int = 1
    
    
    init() {
        
    }
    
    func fetchMovies(type:MovieListType) {
        let request = MovieRequest(type: type.rawValue, page: getCurrentPage(type: type), language: "en-US")
        MovieService().fetchMoviesList(request: request) {[weak self] (response) in
            switch response {
            case .success(let result):
                self?.updateCurrentPage(type: type, page: result?.page)
                self?.receivedList?(result)
                break
            case .failure(let reason):
                self?.onError?(reason.localizedDescription)
                break
            }
        }
    }
    
    private func getCurrentPage (type:MovieListType) -> Int {
        
        switch  type {
        case .Popular:
            return currentPagePopular
            
        case .TopRated:
            return currentPageTopRated
            
        case .Upcoming:
            return currentPageUpcoming
        }
    }
    
    private func updateCurrentPage (type:MovieListType, page: Int?) {
        
        switch  type {
        case .Popular:
            currentPagePopular = (page ?? 1) + 1
            break
        case .TopRated:
            currentPageTopRated = (page ?? 1) + 1
            break
            
        case .Upcoming:
            currentPageUpcoming = (page ?? 1) + 1
            break
        }
    }
    
}
