//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {
    
    private func printMovieList(movieList: MovieDbAPICaller.MovieListResponse){
        print(movieList.results.first)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieDbCaller = MovieDbAPICaller()
        movieDbCaller.getMovieList(pageID: 1, completionHandler: printMovieList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

