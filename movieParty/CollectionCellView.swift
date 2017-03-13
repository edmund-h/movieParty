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
            if let movie = movie{
                posterLabel.text = movie.title + "-" + movie.year
                moviePosterImage.image = movie.movieImage
                    

            }
        }
    }

    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    func getImageForCell(atURLString imageURLString: String, completion: @escaping (UIImage) -> Void ) {
        print("call to get image for cell received, function is running")
         DispatchQueue.global(qos: .background).async {
            OmdbApiClient.getImage(atUrl: imageURLString) { (data) in
                let image = UIImage(data: data)
                if let image = image {
                    print("image received by view controller function")
                    print("get image for cell completion call")
                    completion(image)
                } else {
                    print("could not get image for cell")
                }
            }
        }
    }
//
}
