//
//  Movie.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
struct Movie : Codable {
    
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [Result]
    
 
}
struct Result : Codable {
         var popularity : Double?
         var id : Int?
         var video : Bool?
         var vote_count : Int?
         var vote_average : Double?
         var title : String?
         var release_date : String?
         var original_language : String?
         var original_title : String?
         var genre_ids : [Int]?
         var backdrop_path : String?
         var adult : Bool?
         var overview : String?
         var poster_path : String? = ""
 }
