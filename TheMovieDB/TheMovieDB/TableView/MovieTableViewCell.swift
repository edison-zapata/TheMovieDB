//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/8/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func prepareForReuse() {
        titleLabel.text = ""
        overviewLabel.text = ""
        posterImage.image = UIImage(named: "iTunesArtwork")
    }

}
