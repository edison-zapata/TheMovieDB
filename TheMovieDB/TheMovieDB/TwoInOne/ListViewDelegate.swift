//
//  MovieList.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/15/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

//MARK: Protocol
protocol ListViewDelegate : class {
    
    func getCellsCount() -> Int
    
    func modifyCell(_ cell: ListCell, cellForItemAt indexPath: IndexPath)
    
}


