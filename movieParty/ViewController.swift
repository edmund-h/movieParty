//
//  ViewController.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataStoreDelegate {
    
    var movie: Movie? = nil
    var movieIndex: Int? = nil
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var plotField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        DataStore.sharedInstance.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        guard let movieIndex = movieIndex else {print("did not get movie index"); return}
        //DispatchQueue.global(qos: .background).async {
        
        self.movie = DataStore.sharedInstance.updateMovieWithDetailedData(index: movieIndex)
        
           // print ("VC should have updated with detailed info: \(self.plotField.text) from \(self.movie?.plot)")
        
      // }
        self.displayInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayInfo()
    }
    
    func displayInfo() {
        self.titleLabel.text = movie?.title
        self.plotField.text = movie?.plot
        self.genreLabel.text = movie?.genre
        self.yearLabel.text = movie?.year
        self.posterImage.image = movie?.movieImage
        
        UIView.animate(withDuration: 0.8) {
            self.titleLabel.alpha = 1
            self.plotField.alpha = 1
            self.genreLabel.alpha = 1
            self.yearLabel.alpha = 1
            self.posterImage.alpha = 1
        }
    }
    
    func updateWithNewMovies(movies: [Movie]) {
//        print(movies)
//        guard let movieIndex = movieIndex else {return}
        print ("movie plot is \(movies[0].plot)")
        movie = movies[0]
        print ("VC updated with \(movie?.plot)")
        displayInfo()
    }
}

