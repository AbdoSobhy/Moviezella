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
    
    func configureCell(movie : MovieResult , genre : [Genre]){
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        self.movieImage.kf.setImage(with: URL(string: baseImageUrl+movie.poster_path!))
        getGenre(movies : movie , genres : genre)
        self.movieTitle.text = movie.title
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func getGenre(movies : MovieResult ,genres : [Genre]) {
        var movieGenres = [String]()
        for movieId in movies.genre_ids! {
            for genreId in genres {
                if genreId.id == movieId{
                    movieGenres.append(genreId.name)
                    let genresWithSeperators = movieGenres.joined(separator: ", ")
                    self.movieGenre.text? = genresWithSeperators
                    
                }
            }
        }
    }
    
}
