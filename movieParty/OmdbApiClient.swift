//
//  OmdbApiClient.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import Foundation

class OmdbApiClient{
    static weak var movieSearchDelegate: MovieSearchDelegate? = DataStore.sharedInstance
    static weak var titleSearchDelegate: TitleSearchDelegate?
    class func getMeSomeMovies (titleSearch:String){
        print("getMeSomeMovies called")
        let titleSearchFormatted = formatForSearch(titleSearch)
        let omdbAddr = "https://omdbapi.com/?s="+titleSearchFormatted
        let omdbUrl = URL(string: omdbAddr)
        let session = URLSession.shared
        guard let omdbUrla = omdbUrl else {print("something fucked up"); return}
        print("URL check complete: \(omdbUrla.absoluteString)")
        let task = session.dataTask(with: omdbUrla, completionHandler: {(data , response, error) in
            do{
                guard let data = data else {print("something's not right"); return}
                print("data received")
                let sessionData = try JSONSerialization.jsonObject(with: data, options: [])
                if let searchDict = sessionData as? [String : Any]{
                    if let searchResults = searchDict["Search"] as? [[String:Any]]{
                        print("movies found in API Client")
                        print("sending results to dataStore")
                        movieSearchDelegate?.updateWithNewData(data: searchResults)
                    }else {print ("data could not be formatted")}
                }else {print ("data could not be serialized")}
                
            }catch{}
            
        })
        task.resume()
        
        
        
    }
    
    class func getASpecificMovie(titleSearch: String){
        print ("going to try to get \(titleSearch)")
        let titleSearchFormatted = formatForSearch(titleSearch)
        let omdbAddr = "https://omdbapi.com/?t="+titleSearchFormatted
        let omdbUrl = URL(string: omdbAddr)
        let session = URLSession.shared
        guard let omdbUrla = omdbUrl else {print("something fucked up"); return}
        print("URL check complete: \(omdbUrla.absoluteString)")
        let task = session.dataTask(with: omdbUrla, completionHandler: {(data , response, error) in
            do{
                guard let data = data else {print("something's not right"); return}
                print("data received")
                let sessionData = try JSONSerialization.jsonObject(with: data, options: [])
                if let searchDict = sessionData as? [String : Any]{
                    //if let searchResults = searchDict["Search"] as? [String:Any]{
                        print("movie found in API Client")
                        print("\(searchDict)")
                    //this conditional is not needed as the data comes as just one dictionary
                    //}else {print ("data could not be formatted")}
                }else {print ("data could not be serialized")}
                
                
            }catch{}
            
        })
        task.resume()
        
    }// just copy pasted the functions from precious method, we can clean this up later
    
    //TODO: image download method
    
    fileprivate class func formatForSearch(_ searchString: String) -> String{
        let temp = searchString.components(separatedBy: CharacterSet(charactersIn: " ,./`!@#$%^&*()_{}|[]<>?:"))
        return temp.joined(separator: "+")
    }
    
}

protocol MovieSearchDelegate:class{
    func updateWithNewData(data: [[String:Any]])
}

protocol TitleSearchDelegate:class {
    func addMovieData(data: [String:Any])
}



//TODO: image download protocol





