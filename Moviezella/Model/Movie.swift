//
//  Movie.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
class Movie : Codable {
    
    var page : Int
    var total_results : Int
    var total_pages : Int
    var results : [MovieResult]
    
 
}
class MovieResult : Codable {
         var vote_count : Int?
         var vote_average : Double?
         var title : String?
         var release_date : String?
         var genre_ids : [Int]?
         var adult : Bool?
         var overview : String?
         var poster_path : String? = ""
 }

class ayhaga {
    var name : String?
    var age : Int?
}
