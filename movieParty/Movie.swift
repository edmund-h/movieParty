//
//  Movie.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import Foundation

class Movie {
    let title: String
    let year: String
    let imdbID: String
    let posterURL: String
    var plot: String? = nil
    var genre: String? = nil

    
    
    init(title: String, year: String, imdbID: String, posterURL: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.posterURL = posterURL
    }
    
    func addDetailedInfo(plot: String, genre: String) {
        self.plot = plot
        self.genre = genre
    }

}
