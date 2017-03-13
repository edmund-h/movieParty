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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityInd.stopAnimating()
        activityInd.isHidden = true
        let movieSearchBar = UISearchBar()
        navigationItem.titleView = movieSearchBar
        movieSearchBar.sizeToFit()
        globalMovieSearchBar = movieSearchBar
        layoutCells()
        store.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.delegate = self
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCellView
        let movieToAdd = movies[indexPath.item]
        cell.movie = movieToAdd
        cell.getImageForCell(atURLString: movieToAdd.posterURL, completion: { (image) in
            cell.movie?.movieImage = image
            cell.moviePosterImage.image = image
            self.movies[indexPath.item].movieImage = image
            DataStore.sharedInstance.updateWithMovieImage (imageToAdd: image, index: indexPath.item)
        })
        return cell
    }

     func updateWithNewMovies(movies: [Movie]) {
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        activityInd.isHidden = false
        activityInd.startAnimating()
        guard let searchString = globalMovieSearchBar.text else {return}
        globalMovieSearchBar.text = ""
        movies = []
        store.removeAllStoredMovies()
        //DispatchQueue.global(qos: .background).async{
            OmdbApiClient.getMeSomeMovies(titleSearch: searchString)
                self.collectionView?.reloadData()
                self.activityInd.stopAnimating()
                self.activityInd.isHidden = true
      // }
    }
    
    
    
    // MARK: UICollectionViewDelegate


    func layoutCells() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenHeight/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView?.collectionViewLayout = layout

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "movieDetailSegue" else {print("segue identifier error"); return}
        let indexPaths = self.collectionView?.indexPathsForSelectedItems
        if let selectedCellNumber = indexPaths?[0].item {
            let dest = segue.destination as! ViewController
            dest.movie = self.movies[selectedCellNumber]
            dest.movieIndex = selectedCellNumber
        }
    }
}
