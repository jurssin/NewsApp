//
//  RealmMethods.swift
//  NewsApp
//
//  Created by User on 9/20/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMethods {
    
      static func readMovie(query: String = "") -> [Movie] {
          
          var cachedMovieArray: [Movie] = []
          do {
              let realm = try Realm()
              let results = realm.objects(MovieCached.self)
              if query == "" {
                  results
                      .map {Movie(movie: $0)}
                      .forEach { movie in
                          cachedMovieArray.append(movie)
                  }
              } else {
                  let queryResults = results.filter("name CONTAINS[cd] %@ || symbol CONTAINS[cd] %@", query, query).sorted(byKeyPath: "rank", ascending: true)
                  queryResults
                      .map {Movie(movie: $0)}
                      .forEach {movie in
                          cachedMovieArray.append(movie)
                  }
              }
          } catch {
              print("Error reading from Realm database: \(error)")
          }
          return cachedMovieArray
      }
      
      static func saveMovie(movies: [Movie]) {
          movies
              .map {MovieCached(movie: $0)}
              .forEach { movie in
                  do {
                      let realm = try Realm()
                      try realm.write {
                          realm.add(movie, update: .all)
                      }
                  } catch {
                      print("Error saving to Realm database: \(error)")
                  }
          }
      }
}
