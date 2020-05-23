//
//  CoreData.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/13/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class CoreData {
    static let shared = CoreData()
    
    func insertMovies(movies : MovieResult) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let movie = MoviesEntity(context: manageContext)
        movie.adult  = movies.adult ?? false
        movie.poster_path = movies.poster_path
        movie.overview = movies.overview
        movie.release_date = movies.release_date
        movie.title = movies.title
        movie.vote_count = Int32(movies.vote_count!)
        movie.vote_average = movies.vote_average ?? 0.0
        movie.genre = movies.genre_ids
        do {
            try manageContext.save()
        } catch {
            print(error)
        }
        
    }
    func deleteRecords() {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let featchRequest = NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
        do {
            let data = try manageContext.fetch(featchRequest)
            if data.count != 0 {
                for object in data{
                    manageContext.delete(object)
                }
                try manageContext.save()
            }
        } catch {
            print(error)
        }
    }
    
    func featchMovies(compleation : @escaping (_ success:[MovieResult]?,_ err:Error?)->Void){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let featchRequest = NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
        do {
            var movies = [MovieResult]()
            let data = try manageContext.fetch(featchRequest)
            for obj in data {
                let mov = MovieResult()
                
                mov.adult = obj.adult
                mov.overview = obj.overview
                mov.poster_path = obj.poster_path
                mov.release_date = obj.release_date
                mov.vote_average = obj.vote_average
                mov.vote_count = Int(obj.vote_count)
                mov.title = obj.title
                mov.genre_ids = obj.genre
                
                movies.append(mov)
            }
            
            compleation(movies,nil)
            
        } catch {
            print(error)
            compleation(nil,error)
        }
    }
}

