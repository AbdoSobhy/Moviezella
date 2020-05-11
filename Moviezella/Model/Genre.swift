//
//  Genre.swift
//  Moviezella
//
//  Created by Abdelrahman Sobhy on 5/11/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation

struct Allgenres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
