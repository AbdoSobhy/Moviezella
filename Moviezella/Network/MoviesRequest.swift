//
//  MoviesRequest.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/6/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import Alamofire
class MoviesRequest {
    static let shared = MoviesRequest()
    
    func featchMovies(_ completionHandeller : @escaping (_ success : Movie , _ error : Error?)->Void) {
        let url = "https://api.themoviedb.org/3/movie/top_rated"
        let apiKey = "90fd0c6e987f62a4def180feaf9edd9a"
        let param = ["api_key": apiKey]
        AF.request(url,parameters: param).responseData { (response : AFDataResponse<Data>) in
            switch response.result{
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(Movie.self, from: data)
                    completionHandeller(jsonData,nil)
                } catch {

                }
                
                
            case .failure(let err):
                print(err)
            }
        }
        
        
        
    }
}
