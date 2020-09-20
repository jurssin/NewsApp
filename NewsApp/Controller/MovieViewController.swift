//
//  ViewController.swift
//  NewsApp
//
//  Created by User on 9/18/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchTopRatedMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - TableView
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "toMovieDetail"  else {
//            return
//        }
//        
//        if let movieDetailView = segue.destination as? MovieDetailViewController {
//            if let cell = sender as? MovieTableViewCell {
//                if let indexPath = tableView.indexPath(for: cell) {
//                    let quote = [indexPath.section]
//                    quoteDetailView.quote = quote
//                }
//                
//                
//            }
//        }
//    }
    
    
}

