//
//  Model.swift
//  NewsApp
//
//  Created by User on 9/19/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation
import RealmSwift

struct MoviesData: Decodable {
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

class Movie: Decodable {
    
    var title = ""
    var year = ""
    var rate = 0.0
    var posterImage = ""
    var overview = ""
    
    convenience init (movie: MovieCached) {
           self.init()
           self.title = movie.title
           self.year = movie.year
           self.rate = movie.rate
           self.posterImage = movie.posterImage
           self.overview = movie.overview
           
       }
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        
    }
    
}
