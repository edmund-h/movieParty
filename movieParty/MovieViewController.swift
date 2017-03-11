//
//  ViewController.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, TitleSearchDelegate {
    
    @IBOutlet weak var movieResultData: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.  
        
        movieResultData.text = "LOADING..."
    }
    
    func addMovieData(data: [String : Any]) {
        let keys = ["Title","Year","Rated","Released","Language","Country","Runtime","Genre","Director","Writer","Actors","Plot","Awards","Metascore","imdbRating","imdbVotes"]
        
        var stringToDisplay = ""
        keys.forEach({ //append title followed by info to a string to the string to display in the text field
            let info = data[$0] as? String ?? "nil"
            stringToDisplay.append($0 + ": " + info + "\n")
            if ["Genre","Actors","Plot"].contains($0){
                stringToDisplay.append("\n")
            }//adds extra linebreak after these three categories
        })
        
        movieResultData.text = stringToDisplay //should display the info in a nicely formatted manner
        
        
        //TODO: Find out why this is not happening
        
    }
    
}//this is a titlesearchdelegate so that it can add data as soon as the title search is done

