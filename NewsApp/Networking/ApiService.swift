//
//  ApiService.swift
//  NewsApp
//
//  Created by User on 9/19/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getMoviesData(completion: @escaping (Result <MoviesData, Error>) -> Void) {
        
        let moviesUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=89aa270fa7dafe2352e5267e035db6ec&language=en-US&page=1"
        
        guard let url = URL(string: moviesUrl) else {
            return
        }
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
