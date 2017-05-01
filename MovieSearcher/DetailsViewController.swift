//
//  DetailsViewController.swift
//  MovieSearcher
//
//  Created by Erick Torres on 4/28/17.
//  Copyright © 2017 Erick Torres. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var currentMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        movieTitleLabel.text = currentMovie.originalTitle
        imageView.downloadImageFrom(url: NetworkManager.Globals.URLs.IMG + currentMovie.posterPath)
        overviewTextView.text = currentMovie.overview.removingPercentEncoding
    }

}
