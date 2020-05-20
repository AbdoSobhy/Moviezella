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
        movie.genre = "Should be here"
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
                
                mov.adult = true
                mov.overview = "obj.value(forKey: ) as? String"
                mov.poster_path = " sdfd"
                mov.release_date = "fdsffds"
                mov.vote_average = 0.0
                mov.vote_count = 0
                mov.title = "ffgdf"
                mov.genre_ids = [32,32,4]
                
                print(mov)
                movies.append(mov)
                
            }
            
            compleation(movies,nil)
            
        } catch {
            print(error)
            compleation(nil,error)
        }
    }
}

