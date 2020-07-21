//
//  MoviesDetailsVC.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import UIKit

class MoviesDetailsVC: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genereLabel: UILabel!
    @IBOutlet weak var producedByLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    var detailsPresenter : MovieDetailsPresenterModeling! {
        didSet {
            detailsPresenter.refreshView = {[weak self] in
                DispatchQueue.main.async {
                    self?.updateUI()
                }
                
            }
            
            detailsPresenter.onError = {[weak self] error in
                
            }
        }
    }
    
    public func instantiate(_ presenter : MovieDetailsPresenter) {
        detailsPresenter = presenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.fetchDetails()
    }
    
    
    private func updateUI () {
        posterImage.downloaded(from: detailsPresenter.getMovieBackdrop() ?? "", contentMode: .scaleAspectFill)
        
        titleLabel.text = detailsPresenter.getMovieTitle()
        durationLabel.text = detailsPresenter.getMovieDuration()
        
        popularityLabel.text = detailsPresenter.getMoviePopularity()
        ratingLabel.text = detailsPresenter.getMovieRating()
        votesCountLabel.text = detailsPresenter.getMovieVotesCount()
        
        tagLineLabel.text = "Tagline:\n" + (detailsPresenter.getMovieTagline() ?? "")
        overviewLabel.text = "Overview:\n" + (detailsPresenter.getMovieOverview() ?? "")
        genereLabel.text = "Genere:\n" + (detailsPresenter.getMovieGenere() ?? "")
        producedByLabel.text = "Produced by:\n" + (detailsPresenter.getMovieProducedBy() ?? "")
        budgetLabel.text = "Budget:\n" + "$" + (detailsPresenter.getMovieBudget() ?? "")
        revenueLabel.text = "Revenue:\n" + "$" + (detailsPresenter.getMovieRevenue() ?? "")
        
    }
    
}
