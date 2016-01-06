//
//  Film.swift
//  films
//
//  Created by Dulio Denis on 1/2/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import Foundation

class Film {
    var title: String!
    var overview: String!
    var year: String!
    var posterPath: String!
    var voteAverage: String!
    
    init(filmDictionary: Dictionary<String, AnyObject>) {
        if let title = filmDictionary["title"] as? String {
            self.title = title
        }
        
        if let year = filmDictionary["release_date"] as? String {
            self.year = year.substringWithRange(Range<String.Index>(start: year.startIndex, end: year.startIndex.advancedBy(4)))
        }
        
        if let overview = filmDictionary["overview"] as? String {
            self.overview = overview
        }
        
        if let voteAverage = filmDictionary["vote_average"] as? Int {
            self.voteAverage = "\(voteAverage) Stars out of 10"
        }
        
        if let path = filmDictionary["poster_path"] as? String {
            self.posterPath = "\(URL_POSTER_BASE)\(path)"
        }
    }
}