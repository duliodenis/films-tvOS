//
//  FilmCell.swift
//  films
//
//  Created by Dulio Denis on 1/2/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class FilmCell: UICollectionViewCell {
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    var filmYear: String!
    var filmOverview: String!
    var voteAverage: String!
    
    func configureCell(film: Film) {
        if let title = film.title {
            self.filmTitle.text = title
        }
        
        if let year = film.year {
            self.filmYear = year
        }
        
        if let overview = film.overview {
            self.filmOverview = overview
        }
        
        if let voteAverage = film.voteAverage {
            self.voteAverage = voteAverage
        }
        
        if let path = film.posterPath {
            let url = NSURL(string: path)!
            
            // download the poster in a background thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url)!
                
                // Update the UI on the main thread once complete
                dispatch_async(dispatch_get_main_queue()) {
                    self.filmPoster.image = UIImage(data: data)
                }
            }
        }
    }
}
