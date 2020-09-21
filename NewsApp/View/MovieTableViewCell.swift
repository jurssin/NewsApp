//
//  MovieTableViewCell.swift
//  NewsApp
//
//  Created by User on 9/20/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString: String = ""
    
    // Setup movies values
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    // Update the UI views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        self.movieReleaseDate.text = convertDateFormatter(releaseDate)
        guard let rate = rating else {
            return
        }
        self.movieRate.text = String(rate)
        self.movieOverview.text = overview
        
        guard let posterString = poster else {
            return
        }
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageUrl = URL(string: urlString) else {
            self.movieImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.movieImage.image = nil
        getImageData(url: posterImageUrl)
    }
    
    // MARK: - Get image data
    
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCahe") as? [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    private func getImageData(url: URL) {
        
        if let dict = UserDefaults.standard.object(forKey: "ImageCahe") as? [String: String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)
                }
            }
        }

        URLSession.shared.dataTask(with: url) { ( data, response, error) in
            // Handle error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data)  {
                    MovieTableViewCell.storeImage(urlString: self.urlString, img: image)
                    self.movieImage.image = image
                }
            }
        }.resume()  
    }
    
    // MARK: - Convert date format
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    
}
