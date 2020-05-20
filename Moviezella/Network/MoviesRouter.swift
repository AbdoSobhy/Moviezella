//
//  MoviesRouter.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/10/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import Alamofire
enum MoviesRouter : URLRequestConvertible {
    enum constent {
       static let api_token = "90fd0c6e987f62a4def180feaf9edd9a"
    }
    case topRated(pageNumber : Int)
    case genre
    
    var url : URL {
        switch self {
        case .topRated:
            return URL(string: "https://api.themoviedb.org/3/movie/top_ratedd")!
        case .genre:
            return URL(string: "https://api.themoviedb.org/3/genre/movie/list")!
        }
    }
        var method : HTTPMethod{
            switch self {
            case .topRated:
               return .get
            case .genre:
                return .get
            }
        }
        var paramiters : Parameters?{
            switch self {
            case .topRated(let pageNumber):
                return ["api_key":constent.api_token,
                        "page":pageNumber]
            case .genre:
                return ["api_key":constent.api_token]
            }
        }
        func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.method = method
            return try URLEncoding.default.encode(urlRequest, with: paramiters)
     }
}
