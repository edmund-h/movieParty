//
//  CollectionCellView.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

class CollectionCellView: UICollectionViewCell {

    var movie: Movie?{
        didSet{
            print("movie value for COllection Cell has been set")
            if let movie = movie{
                posterLabel.text = movie.title + "-" + movie.year
                print("labels for movie cell should be set")
                //posterLabel.adjustsFontForContentSizeCategory = true
                posterLabel.numberOfLines = 0
                posterLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                //posterLabel.adjustsFontSizeToFitWidth = true
            }
        }
    }

  //  @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterLabel: UILabel!
//
}
