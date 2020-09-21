//
//  MovieDetailViewController.swift
//  NewsApp
//
//  Created by User on 9/20/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    var movie: Movie? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = movie {
            nameLabel.text = movie.title
            overviewLabel.text = movie.overview
            releaseDate.text = "Release date: \(movie.year)"
            ratingLabel.text = "Rating: \(movie.rate)"
            
            let urlString = "https://image.tmdb.org/t/p/w300" + movie.posterImage
            let url = URL(string: urlString)!
            let session = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            })
            session.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
