//
//  MovieListPresenter.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

enum MovieListType : Int {
    case Popular = 0
    case TopRated
    case Upcoming
}

protocol MovieListPresenterModeling : class {
    
    func getMoviesCount () -> Int
    func getMovie(at index:Int) -> Movie?
    
    func updateMovieListType (type:MovieListType, indexPath:IndexPath?)
    func fetchMovies()
    
    func didSelectMovie(movie:Movie)
    
    typealias onErrorAlias = (String) -> ()
    var onError : onErrorAlias? {get set}
    
    typealias refreshViewAlias = (IndexPath?) -> ()
    var refreshView : refreshViewAlias? {get set}
    
}

class MovieListPresenter : MovieListPresenterModeling {
    
    var listInteractor : MovieListInteractorModeling! {
        didSet {
            listInteractor.receivedList = {[weak self] list in
                if let results = list?.results, let type = self?.type {
                    switch type {
                    case .Popular:
                        self?.popularMoviesList.append(contentsOf: results)
                        self?.refreshView?(self?.popularLastVisibleIndex)
                        break
                    case .TopRated:
                        self?.topRatedMoviesList.append(contentsOf: results)
                        self?.refreshView?(self?.topRatedLastVisibleIndex)
                        break
                    case .Upcoming:
                        self?.upcomingMoviesList.append(contentsOf: results)
                        self?.refreshView?(self?.upcomingLastVisibleIndex)
                        break
                    }
                }
                
            }
            listInteractor.onError = {[weak self] error in
                self?.onError?(error)
            }
            
        }
    }
    
    var listRouter : MovieListRouterModeling! {
        didSet {
            
        }
    }
    
    var onError: MovieListPresenterModeling.onErrorAlias?
    var refreshView: MovieListPresenterModeling.refreshViewAlias?
    
    private var type : MovieListType = .Popular
    
    
    private var popularMoviesList = Array<Movie>()
    private var topRatedMoviesList = Array<Movie>()
    private var upcomingMoviesList = Array<Movie>()
    
    private var popularLastVisibleIndex : IndexPath?
    private var topRatedLastVisibleIndex : IndexPath?
    private var upcomingLastVisibleIndex : IndexPath?
    
    
    init() {}
    
    func getMoviesCount () -> Int {
        return currentList().count
    }
    
    func getMovie(at index:Int) -> Movie? {
        return currentList()[index]
    }
    
    func fetchMovies() {
        listInteractor.fetchMovies(type: type)
    }
    
    func updateMovieListType (type:MovieListType, indexPath:IndexPath?) {
        print(indexPath)
        switch self.type {
        case .Popular:
            popularLastVisibleIndex = indexPath
            break
        case .TopRated:
            topRatedLastVisibleIndex = indexPath
            break
        case .Upcoming:
            upcomingLastVisibleIndex = indexPath
            break
        }
        
        self.type = type
        fetchMovies()
    }
    
    func currentList () -> Array<Movie> {
        switch type {
        case .Popular:
            return popularMoviesList
        case .TopRated:
            return topRatedMoviesList
        case .Upcoming:
            return upcomingMoviesList
            
        }
    }
    
    
    func didSelectMovie(movie:Movie) {
        listRouter.showMovieDetails(movie: movie)        
    }
}

