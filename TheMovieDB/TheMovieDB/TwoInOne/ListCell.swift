//
//  File.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/15/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
import UIKit

protocol ListCell {
    var titleLabel: UILabel! { get }
    var overviewLabel: UILabel? { get }
    var posterImage: UIImageView! { get }
}

class ListTableCell : UITableViewCell, ListCell {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel?
    @IBOutlet weak var posterImage: UIImageView!
    
}

class ListCollectionCell : UICollectionViewCell, ListCell {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel?
    @IBOutlet weak var posterImage: UIImageView!
    
}
