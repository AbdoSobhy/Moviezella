//
//  ViewController.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    var Movies = [Result]()
    @IBOutlet weak var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        MoviesRequest.shared.featchMovies { (result, err) in
            if result.results.isEmpty != true {
                self.Movies = result.results
                self.moviesTableView.reloadData()
            }
        }
    }
}
extension MoviesVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        cell.configureCell(movie: Movies[indexPath.row])
        return cell
    }
    
    
}
extension MoviesVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedMovieVC = storyboard?.instantiateViewController(withIdentifier: "DetailedMovieVC") as? DetailedMovieVC else {return}
        detailedMovieVC.movie = self.Movies[indexPath.row]
        detailedMovieVC.modalPresentationStyle = .fullScreen
        present(detailedMovieVC,animated: true,completion: nil)
        
    }
}

