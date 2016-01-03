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
    var posterPath: String!
    
    init(filmDictionary: Dictionary<String, AnyObject>) {
        if let title = filmDictionary["title"] as? String {
            self.title = title
        }
        
        if let overview = filmDictionary["overview"] as? String {
            self.overview = overview
        }
        
        if let path = filmDictionary["poster_path"] as? String {
            self.posterPath = "\(URL_POSTER_BASE)\(path)"
        }
    }
}