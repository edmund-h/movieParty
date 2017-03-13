//
//  DetailDataStore.swift
//  movieParty
//
//  Created by Patrick O'Leary on 3/11/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import Foundation

class DetailDateStore: MovieDetailDelegate {
    static let sharedInstance = DetailDateStore()
    title
    year
    rated
    genre
    director
    actors
    poster
    plot
    imdbID
    
    private init() {
        
    }
    
    func updateWithNewData(data: [String : String]) {
        //do some stuff
    }
    
}
