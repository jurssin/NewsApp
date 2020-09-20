//
//  ModelViewModel.swift
//  NewsApp
//
//  Created by User on 9/20/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var topRatedMovies = [Movie]()
    
    func fetchTopRatedMoviesData(completion: @escaping () -> ()) {
        
        apiService.getMoviesData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.topRatedMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func numberOfRowInSection(section: Int) -> Int {
        if topRatedMovies.count != 0 {
            return topRatedMovies.count
        }
        return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return topRatedMovies[indexPath.row]
    }
}
