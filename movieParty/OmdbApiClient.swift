//
//  OmdbApiClient.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//
// testCase branch

import Foundation

class OmdbApiClient{
    static weak var movieSearchDelegate: MovieSearchDelegate? = DataStore.sharedInstance

    class func getMeSomeMovies (titleSearch:String){
        print("getMeSomeMovies called")
        let titleSearchFormatted = formatForSearch(titleSearch)
        let omdbAddr = "https://omdbapi.com/?s="+titleSearchFormatted
        let omdbUrl = URL(string: omdbAddr)
        DispatchQueue.global(qos: .background).async{
            let session = URLSession.shared
            guard let omdbUrla = omdbUrl else {print("something fucked up"); return}
            print("URL check complete: \(omdbUrla.absoluteString)")
            let task = session.dataTask(with: omdbUrla, completionHandler: {(data , response, error) in
                do{
                    guard let data = data else {print("something's not right"); return}
                    print("data received")
                    let sessionData = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        if let searchDict = sessionData as? [String : Any]{
                            if let searchResults = searchDict["Search"] as? [[String:Any]]{
                                print("movies found in API Client")
                                print("sending results to dataStore")
                                movieSearchDelegate?.updateWithNewData(data: searchResults)
                            }else {print ("data could not be formatted")}
                        }else {print ("data could not be serialized")}
                    }// data is added to data store on main queue
                }catch{}
            })
            task.resume()
        }//internet connection happens in background off main queue
    }
    
    class func getDetailedInfo(forTitle title: String) {
        print("get detailed info called")
        let temp = title.components(separatedBy: CharacterSet(charactersIn: " ,./`!@#$%^&*()_{}|[]<>?:"))
        let formattedTitle = temp.joined(separator: "+")
        let omdbAddr = "https://omdbapi.com/?t=" + formattedTitle
        let omdbURL = URL(string: omdbAddr)
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            guard let omdbURLuw = omdbURL else {print("detailed OMDB info not retrieved"); return}
            print("url check complete")
            let task = session.dataTask(with: omdbURLuw) { (data, response, error) in
                do {
                    guard let data = data else {print("no detailed movie data returned"); return}
                    let sessionData = try JSONSerialization.jsonObject(with: data, options: [])
                        DispatchQueue.main.async {
                            print(sessionData)
                            if let searchResults = sessionData as? [String : String] {
                                print("updating movie in datastore with detailed data")
                                DataStore.sharedInstance.updateWithDetailedData(data: searchResults)
                        }//data comes into the view on the main queue
                    }
                } catch {}
            }
            task.resume()
        }//data is downloaded in background, off main queue
    }
    
    class func getImage(atUrl imageURLString: String, with completion: @escaping (Data) -> Void) {
        
        print("function to get image from URL has been called")
        var imageURL = URL(string: imageURLString)
        guard let imageURLuw = imageURL else {print("Image could not be found"); return}
        DispatchQueue.global(qos: .background).async {            let session = URLSession.shared
            let task = session.dataTask(with: imageURLuw) { (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        print("image data succesfully found")
                        completion(data)//this goes straight to the imageview that is downloading the image
                    } else {
                        print("image url returned no data")
                    }
                }//images sent into cells on main queue
            }
            task.resume()
        }
    }

    fileprivate class func formatForSearch(_ searchString: String) -> String{
        let temp = searchString.components(separatedBy: CharacterSet(charactersIn: " ,./`!@#$%^&*()_{}|[]<>?:"))
        return temp.joined(separator: "+")
    }
}

protocol MovieSearchDelegate: class {
    func updateWithNewData(data: [[String:Any]])
    func updateWithDetailedData(data: [String : String])
}
