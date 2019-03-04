//
//  Movie.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 2/27/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

struct Genre : Codable{
    var id: Int
    var name: String?
}

class Movie : Codable, CustomStringConvertible {
    
    var description: String {
        return "Title: \(title)\nPoster: \(poster)\nOverview: \(overview)\n"
    }
    
    var id: Int
    var title: String
    var overview: String
    var poster: String
    var adult: Bool?
    var genres: [Genre]?
    
    enum CodingKeys : String, CodingKey {
        case poster = "poster_path"
        
        case id
        case title
        case overview
        case adult
        case genres
    }
    
    init(id: Int, title: String, poster: String, overview: String) {
        self.id = id
        self.title = title
        self.poster = poster
        self.overview = overview
    }
    
}
