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
    
    func getGenre(handeler : @escaping (_ success : Allgenres ,_ error : Error?)->Void)  {
        AF.request(MoviesRouter.genre).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(Allgenres.self, from: data)
                    handeler(jsonData,nil)
                } catch {
                    print("cant parse")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getTopRatedMovie(pageNumber : Int ,_ handeler: @escaping (_ success : Movie ,_ error : Error?) -> Void ) {
        AF.request(MoviesRouter.topRated(pageNumber: pageNumber)).responseData { (respnonse) in
            switch respnonse.result{
            case .success(let data):
                
                do {
                     let jsonData = try JSONDecoder().decode(Movie.self, from: data)
                    handeler(jsonData,nil)

                } catch  {
                    print("Cant Parse")
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
