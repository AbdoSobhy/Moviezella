//
//  DetailedMovieVC.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

class DetailedMovieVC: UIViewController {
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var adult: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var voteAvarage: UILabel!
    var movie = Result()
    @IBOutlet weak var movieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData(curentMovie: movie)
      
        
    }
    func fillData(curentMovie : Result) {
        /// image
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        self.movieImage.kf.setImage(with: URL(string: baseImageUrl+movie.poster_path!))
        /// adult
        self.overView.text! += curentMovie.overview ?? " "
        switch curentMovie.adult {
        case true:
            self.adult.text! += "Yes"
        case false:
            self.adult.text! += "No"
        default:
            self.adult.text! += " "
        }
        /// relased Date
        self.releaseDate.text! += curentMovie.release_date ?? " "
        /// vote count
        self.voteCount.text! += String(curentMovie.vote_count ?? 0)
        self.voteAvarage.text! += String(curentMovie.vote_average ?? 0.0)
    }
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
