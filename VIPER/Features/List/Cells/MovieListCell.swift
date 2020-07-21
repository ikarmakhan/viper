//
//  MovieListCell.swift
//  VIPER
//
//  Created by  on 20/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var movie : Movie! {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

    private func config () {
        titleLabel.text = movie.originalTitle
        detailsLabel.text = movie.overview
        
        if var image = movie.posterPath {
            image = "https://image.tmdb.org/t/p/w500" + image
            moviePoster.downloaded(from: image, contentMode: .scaleAspectFill)
        }
        else {
            moviePoster.image = nil
        }
        
    }
    
}

