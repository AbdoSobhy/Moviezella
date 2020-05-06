//
//  MovieCell.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import Kingfisher
class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    func configureCell(movie : Result){
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        self.movieImage.kf.setImage(with: URL(string: baseImageUrl+movie.poster_path!))
        self.movieGenre.text = "Gener should be here"
        self.movieTitle.text = movie.title
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
