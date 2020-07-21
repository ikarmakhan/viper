//
//  MovieDetailsPresenter.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterModeling : class {
    func fetchDetails()
    
    func getMovieBackdrop () -> String?
    func getMovieTitle() -> String?
    func getMovieDuration () -> String?
    func getMoviePopularity () -> String?
    func getMovieRating () -> String?
    func getMovieVotesCount () -> String?
    func getMovieTagline () -> String?
    func getMovieOverview () -> String?
    func getMovieGenere () -> String?
    func getMovieProducedBy () -> String?
    func getMovieBudget () -> String?
    func getMovieRevenue () -> String?
    
    typealias onErrorAlias = (String) -> ()
    var onError : onErrorAlias? {get set}
    
    typealias refreshViewAlias = () -> ()
    var refreshView : refreshViewAlias? {get set}
    
}

class MovieDetailsPresenter : MovieDetailsPresenterModeling {
    
    var detailsInteractor : MovieDetailsInteractorModeling! {
        didSet {
            detailsInteractor.receivedDetails = {[weak self] details in
                self?.movieDetails = details
                print(details)
                self?.refreshView?()
            }
            
            detailsInteractor.onError = {[weak self] error in
                self?.onError?(error)
            }
        }
    }
    
    var detailsRouter : MoviesDetailsRouterModeling! {
        didSet {
            
        }
    }
    
    var onError: MovieDetailsPresenterModeling.onErrorAlias?
    var refreshView: MovieDetailsPresenterModeling.refreshViewAlias?
    
    private var movie : Movie?
    private var movieDetails : MovieDetails?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    
    func fetchDetails() {
        detailsInteractor.fetchMovieDetails(movieId: self.movie?.id ?? 0)
    }
    
    func getMovieBackdrop () -> String? {
        if let image = movieDetails?.backdropPath {
            return "https://image.tmdb.org/t/p/original" + image
        }
        return nil
    }
    
    func getMovieTitle() -> String? {
        return movieDetails?.title
    }
    func getMovieDuration () -> String? {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: TimeInterval((movieDetails?.runtime ?? 0) * 60))!
        print(formattedString)
        return formattedString
//        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: movieDetails?.runtime ?? 0)
//        return "\(h):\(m):\(s)"
    }
    
    func getMoviePopularity () -> String? {
        return "\(movieDetails?.popularity ?? 0.0)"
    }
    
    func getMovieRating () -> String? {
        return "\(movieDetails?.voteAverage ?? 0.0)"
    }
    
    func getMovieVotesCount () -> String? {
        return "\(movieDetails?.voteCount ?? 0)"
    }
    
    func getMovieTagline () -> String? {
        return movieDetails?.tagline
    }
    
    func getMovieOverview () -> String? {
        return movieDetails?.overview
    }
    func getMovieGenere () -> String? {
        if let generes = movieDetails?.genres {
            let names = generes.map { $0.name ?? ""}
            return names.joined(separator: ", ")
        }
        return nil
    }
    
    func getMovieProducedBy () -> String? {
        if let productionHouses = movieDetails?.productionCompanies {
            let names = productionHouses.map {$0.name ?? ""}
            return names.joined(separator: ", ")
        }
        return nil
    }
    
    func getMovieBudget () -> String? {
        return "\((movieDetails?.budget ?? 0)/1000)K"
    }
    
    func getMovieRevenue () -> String? {
        return "\((movieDetails?.revenue ?? 0)/1000)K"
    }
    
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
