//
//  ViewController.swift
//  VIPER
//
//  Created by  on 19/07/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import UIKit

class MoviesListVC: UIViewController {

    @IBOutlet weak var categoriesControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var movieListPresenter : MovieListPresenterModeling! {
        didSet {
            movieListPresenter.onError = {[weak self] message in
                // show error Alert
            }
            
            movieListPresenter.refreshView = {[weak self] indexPath in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    if let indexPath = indexPath {
                        self?.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }
                    else {
                        if self?.tableView.numberOfRows(inSection: 0) ?? 0 > 0 {
                            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    
    public func instantiate(presenter: MovieListPresenter) {
        movieListPresenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: MovieListCell.string, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MovieListCell.string)
        
        movieListPresenter.updateMovieListType(type: .Popular, indexPath: nil)
        tableView.tableFooterView = UIView(frame: .zero)
    }

    @IBAction func categoryChangedAction(_ sender: UISegmentedControl) {
        if let type = MovieListType.init(rawValue: sender.selectedSegmentIndex) {
            movieListPresenter.updateMovieListType(type: type, indexPath: tableView.indexPathsForVisibleRows?.first)
        }
        
    }
    
}

extension MoviesListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListPresenter.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.string, for: indexPath) as! MovieListCell
        cell.movie = movieListPresenter.getMovie(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > movieListPresenter.getMoviesCount() - 3 {
            movieListPresenter.fetchMovies()
        }
    }
    
}

extension MoviesListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = movieListPresenter.getMovie(at: indexPath.row) {
            movieListPresenter.didSelectMovie(movie: movie)
        }
        
    }
    
}
