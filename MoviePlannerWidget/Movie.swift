//
//  Movie.swift
//  iOS
//
//  Created by Alex Brown on 30/06/2020.
//

import Foundation

struct Movie {
    let name: String
    let movieImageName: String
    
    static var empty: Movie {
        Movie(name: "", movieImageName: "")
    }
}
