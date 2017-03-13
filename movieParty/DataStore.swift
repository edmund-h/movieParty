//
//  DataStore.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit
import Foundation

class DataStore: MovieSearchDelegate {
    
    static let sharedInstance = DataStore()
    fileprivate var movies: [Movie] = []
    weak var delegate: DataStoreDelegate?
    
    
    
    private init() {
        
    }
    
    func updateWithNewData(data: [[String : Any]]) {
        print("updating DataStore with Data from APICLient")
        for dictionary in data {
            let title = dictionary["Title"] as? String ?? ""
            let year = dictionary["Year"] as? String ?? ""
            let imdbID = dictionary["imdbID"] as? String ?? ""
            let posterURL = dictionary["Poster"] as? String ?? ""
            var newMovie = Movie(title: title, year: year, imdbID: imdbID, posterURL: posterURL)
            movies.append(newMovie)
        }
        print("data store is telling delegate to update with new movies")
        delegate?.updateWithNewMovies(movies: movies)
    }
    
    func updateWithDetailedData(data: [String:String]) {
       
        let movieToUpdateIMDB = data["imdbID"]
        print("looking to add detailed info for movie imdbID: \(movieToUpdateIMDB)")
        for var movie in movies {
            if movie.imdbID == movieToUpdateIMDB {
                print("Found movie to add details to: \(movie.title)")
                let plot = data["Plot"] ?? ""
                let genre = data["Genre"] ?? ""
                movie.addDetailedInfo(plot: plot, genre: genre)
            }
        }
    }
    
    func removeAllStoredMovies() {
        self.movies = []
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
    func updateWithMovieImage (imageToAdd: UIImage, index: Int){
        self.movies[index].movieImage = imageToAdd
    }
    
    func updateMovieWithDetailedData (index: Int)-> Movie {
        print ("calling APIclient to get new data")
        OmdbApiClient.getDetailedInfo(forTitle: self.movies[index].title)
        return movies[index]
    }
}

protocol DataStoreDelegate: class {
    func updateWithNewMovies(movies: [Movie])
}

