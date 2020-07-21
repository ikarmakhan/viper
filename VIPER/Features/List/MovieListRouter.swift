//
//  MovieListRouter.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListRouterModeling : class {
    func showMovieDetails(movie:Movie)
}

class MovieListRouter : MovieListRouterModeling {
    private var navigationController : UINavigationController?
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func createModule () -> MoviesListVC {
        let vc = MoviesListVC.instantiate(withStoryBoard: .Home)
        let presenter = MovieListPresenter()
        vc.instantiate(presenter: presenter)
        presenter.listInteractor = MovieListInteractor()
        presenter.listRouter = self
        return vc
    }
    
    func showMovieDetails(movie:Movie) {
        let detailsModule = MoviesDetailsRouter.init(navigationController: navigationController) .createModule(movie: movie)
        navigationController?.pushViewController(detailsModule, animated: true)
    }
    
    
}
