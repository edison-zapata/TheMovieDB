//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var listView: ListView!
    var movies = [Movie]()
    let isiPad = UIDevice.current.userInterfaceIdiom == .pad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isiPad) {
            listView = ListCollectionView(frame: view.frame, collectionViewLayout: MovieUICollectionViewFlowLayout())
        } else {
            listView = ListTableView(frame: view.frame, style: UITableView.Style.plain)
        }
        listView.listDelegate = self
        let viewOfListView = listView as! UIView
        view.addSubview(viewOfListView)
        viewOfListView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: viewOfListView, attribute: .top, relatedBy: .equal, toItem: view.subviews[0], attribute: .bottom , multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: viewOfListView, attribute: .bottom, relatedBy: .equal, toItem: view.subviews[1], attribute: .bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: viewOfListView, attribute: .leading , relatedBy: .equal, toItem: view, attribute: .leading , multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: viewOfListView, attribute: .trailing , relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraints(constraints)
        //Get the movies
        requestMovies(pageID: 1)
    }
    
    func requestMovies(pageID: Int){
        MovieDbAPICaller.getMovieList(pageID: pageID){
            movieListResponse, error in
            guard let movieResponse = movieListResponse else{
                print("MovieTableViewController.requestMovies -> \(error as Any)")
                return
            }
            self.movies += movieResponse.results
            self.listView.reloadData()
        }
    }

}

extension ViewController : ListViewDelegate {
    
    func getCellsCount() -> Int {
        return movies.count
    }
    
    func modifyCell(_ cell: ListCell, cellForItemAt indexPath: IndexPath) {
        //Request more movies if the user reachs the bottom of the list
        if(indexPath.row == movies.count - 2){
            requestMovies(pageID: (movies.count / 20) + 1)
        }
        // Table view cells are reused and should be dequeued using a cell identifier.
        /*guard let cell = listView
            else{
            fatalError("The dequeued cell is not an instance of MovieTableViewCell.")
        }*/
        // Fetches the appropriate movie for the data source layout.
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.overviewLabel?.text = movie.overview
        if (isiPad) {
            cell.posterImage.isHidden = movie.poster == nil
            cell.titleLabel.isHidden = !cell.posterImage.isHidden
        }
        if let posterPath = movie.poster,
            let url = URL(string: "https://image.tmdb.org/t/p/w92\(posterPath)") {
            cell.posterImage.af_setImage(withURL: url)
        }
    }
}
