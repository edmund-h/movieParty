//
//  MovieCollectionVC.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MovieCollectionVC: UICollectionViewController, DataStoreDelegate {
    let store = DataStore.sharedInstance
    var movies: [Movie] = []
    weak var globalMovieSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var movieSearchBar = UISearchBar()
        navigationItem.titleView = movieSearchBar
        movieSearchBar.sizeToFit()
        globalMovieSearchBar = movieSearchBar
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        store.delegate = self
        
    }

    /*


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("number of movies \(movies.count)")
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionCellView
       
        cell?.movie = movies[indexPath.item]
        print ("dequeueCell done")
        return cell!
    }

 
    func updateWithNewMovies(movies: [Movie]) {
        print("view controller is updating with new movies")
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    //TODO: implement image searching for onscreen cells
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        guard let searchString = globalMovieSearchBar.text else {return}
        globalMovieSearchBar.text = ""
        movies = []
        self.collectionView?.reloadData()
        DispatchQueue.main.async{
            OmdbApiClient.getMeSomeMovies(titleSearch: searchString)
            print ("asked for movies")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let origin = sender as? CollectionCellView else {return}
        guard let movieToDisplay = origin.movie else {return}
        DispatchQueue.main.async {
            OmdbApiClient.getASpecificMovie(titleSearch: movieToDisplay.title)
        }
    }//segue preparation triggers search for add'tl info.
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate


    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
