//
//  ViewController.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import SkeletonView

class MoviesVC: UIViewController {
    var Movies = [Result]()
    var genre = [Genre]()
    var pageNumber = 1
    @IBOutlet weak var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.showAnimatedGradientSkeleton() // Gradient animated
        loadGenres()
        loadData()
    }
    
    func loadGenres(){
        MoviesRequest.shared.getGenre { (result, err) in
           if !result.genres.isEmpty{
            self.genre = result.genres
            }
        }
    }
    func loadData() {
        
        MoviesRequest.shared.getTopRatedMovie(pageNumber: pageNumber) { (result, err) in
            if !result.results.isEmpty{
                self.Movies.append(contentsOf: result.results)
                if result.total_pages > self.pageNumber{
                    self.pageNumber += 1
                }
                self.view.hideSkeleton()
                self.moviesTableView.reloadData()
            }
        }
    }
}
extension MoviesVC: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths{
            if index.row >= Movies.count - 3 {
                loadData()
                break
            }
        }
    }
}

extension MoviesVC : SkeletonTableViewDataSource{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MovieCell"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        cell.configureCell(movie: Movies[indexPath.row], genre: genre)
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

