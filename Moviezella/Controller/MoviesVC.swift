//
//  ViewController.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
//import CoreData
import SkeletonView

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MoviesVC: UIViewController {
    var Movies = [MovieResult]()
    var genre = [Genre]()
    var pageNumber = 1
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres()
        loadData()
    }
    
    
    @available(iOS 11.0, *)
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        view.showAnimatedGradientSkeleton() // Gradient animated
        
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
            if (result != nil) {
                self.Movies.append(contentsOf: result!.results)
                if result!.total_pages > self.pageNumber{
                    self.pageNumber += 1
                }
                self.view.hideSkeleton()
                self.moviesTableView.reloadData()
            }else{
                CoreData.shared.featchMovies { (response, err) in
                    guard let results = response else {return}
                    self.Movies.append(contentsOf: results)
                    self.view.hideSkeleton()
                    self.moviesTableView.reloadData()

                }
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

