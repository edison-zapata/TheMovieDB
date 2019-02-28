//
//  Movie.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 2/27/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

class Movie : Codable, CustomStringConvertible {
    
    var description: String {
        return "Title: \(title)\nPoster: \(poster)\nOverview: \(overview)\n"
    }
    
    
    let title: String
    let poster: String
    let overview: String
    
    enum CodingKeys : String, CodingKey {
        case poster = "poster_path"
        
        case title
        case overview
    }
    
}
