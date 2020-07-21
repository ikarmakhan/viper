//
//  MovieDetailsRouter.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesDetailsRouterModeling : class {
    
}

class MoviesDetailsRouter : MoviesDetailsRouterModeling {
    private var navigationController : UINavigationController?
    
    init(navigationController:UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func createModule (movie:Movie) -> MoviesDetailsVC {
        let vc = MoviesDetailsVC.instantiate(withStoryBoard: .Home)
        let presenter = MovieDetailsPresenter(movie: movie)
        vc.instantiate(presenter)
        presenter.detailsInteractor = MovieDetailsInteractor()
        presenter.detailsRouter = self
        return vc
    }
}
