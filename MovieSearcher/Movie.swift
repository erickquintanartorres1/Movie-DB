//
//  Movie.swift
//  MovieSearcher
//
//  Created by Erick Torres on 4/27/17.
//  Copyright © 2017 Erick Torres. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var originalTitle: String = ""
    var posterPath: String = ""
    var overview: String = ""
    
    class func parseFrom(json: [String: Any]) -> Movie {
    
        let newMovie = Movie()
        if let originaltitle = json["original_title"] as? String {
            newMovie.originalTitle = originaltitle
        }
        if let posterpath = json["poster_path"] as? String {
            newMovie.posterPath = posterpath
        }
        if let overview = json["overview"] as? String {
            newMovie.overview = overview
        }
        return newMovie
        
    }

    
}
