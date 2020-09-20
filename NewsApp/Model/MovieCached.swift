//
//  MovieCached.swift
//  NewsApp
//
//  Created by User on 9/20/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCached: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var year = ""
    @objc dynamic var rate = 0.0
    @objc dynamic var posterImage = ""
    @objc dynamic var overview = ""
    
    override class func primaryKey() -> String? {
        return "rank"
    }
    convenience init (movie: Movie) {
        self.init()
        self.title = movie.title
        self.year = movie.year
        self.rate = movie.rate
        self.posterImage = movie.posterImage
        self.overview = movie.overview
        
    }
}
