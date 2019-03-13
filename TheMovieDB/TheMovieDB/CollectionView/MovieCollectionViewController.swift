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
    let spaceWithinCells: CGFloat = 10
    var movies = [Movie]()

    private let reuseIdentifier = "MovieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //configure flow layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let contentSize = layout.collectionViewContentSize
        let cellsInRow = Int(((contentSize.width+10)/(cellWidth+10)))
        layout.sectionInset.left = (contentSize.width-(cellWidth*CGFloat(cellsInRow))-(CGFloat(cellsInRow)-1)*spaceWithinCells)/2
        layout.sectionInset.right = layout.sectionInset.left
        print(contentSize.width)
        print(cellsInRow)
        
        //Register cell
        let nib: UINib? = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        //Get the movies
        requestMovies(pageID: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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

    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    func requestMovies(pageID: Int){
        MovieDbAPICaller.getMovieList(pageID: pageID){
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
