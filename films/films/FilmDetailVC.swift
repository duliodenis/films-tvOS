//
//  FilmDetailVC.swift
//  films
//
//  Created by Dulio Denis on 1/5/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class FilmDetailVC: UIViewController {

    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var film: FilmCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmTitle.text = film.filmTitle.text
        poster.image = film.filmPoster.image
        overview.text = film.filmOverview
        year.text = film.filmYear
        voteAverage.text = film.voteAverage
    }
}
