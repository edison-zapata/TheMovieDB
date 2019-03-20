//
//  MovieCollectionViewController.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/13/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewController: UICollectionViewController {
    
    let cellWidth: CGFloat = 114
    let cellHeight: CGFloat = 170
    let spaceBetweenCells: CGFloat = 10
    var movies = [Movie]()

    private let reuseIdentifier = "MovieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
 
        //Register cell
        let nib: UINib? = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        //Get the movies
        requestMovies(pageID: 1)
    }

    func requestMovies(pageID: Int) {
        MovieDbAPICaller.getMovieList(pageID: pageID) {
            movieListResponse, error in
            guard let movieResponse = movieListResponse else{
                print("MovieTableViewController.requestMovies -> \(error as Any)")
                return
            }
            self.movies += movieResponse.results
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension MovieCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Request more movies if the user reachs the bottom of the list
        if(indexPath.row == movies.count - 2){
            requestMovies(pageID: (movies.count / 20) + 1)
        }
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else{
            fatalError("The dequeued cell is not an instance of MovieTableViewCell.")
        }
        // Fetches the appropriate movie for the data source layout.
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.posterImage.isHidden = movie.poster == nil
        cell.titleLabel.isHidden = !cell.posterImage.isHidden
        if let posterPath = movie.poster,
            let url = URL(string: "https://image.tmdb.org/t/p/w92\(posterPath)") {
            cell.posterImage.af_setImage(withURL: url)
        }
        return cell
    }
}
