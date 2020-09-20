//
//  ViewController.swift
//  NewsApp
//
//  Created by User on 9/18/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import UIKit
import PullToRefresh
import AnimatableReload
import SwipeCellKit
import RealmSwift

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadPopularMoviesData), for: .valueChanged)
        
        return refreshControl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.refreshControl = refresher
        loadPopularMoviesData()
    }

    @objc private func loadPopularMoviesData() {
        viewModel.fetchTopRatedMoviesData { [weak self] in
            let deadline = DispatchTime.now() + .milliseconds(500)
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                self?.refresher.endRefreshing()
            }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! MovieDetailViewController
                destVC.movie = viewModel.topRatedMovies[indexPath.row]
            }
        }
    }
    


    
    
}

