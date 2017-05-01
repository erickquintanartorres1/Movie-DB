//
//  NetworkManager.swift
//  MovieSearcher
//
//  Created by Erick Torres on 4/27/17.
//  Copyright © 2017 Erick Torres. All rights reserved.
//

import UIKit

protocol NetworkManagerDelegate: class {

    func didFinishSearchingMovies(json: [String: Any])

}

class NetworkManager: NSObject {
    
    weak var delegate: NetworkManagerDelegate?
    
    struct Globals {
        struct Keys {
            static let API_KEY = "d8bd7c131fe1670f13c8ee6bb7808fd1"
        }
        struct URLs {
            static let IMG = "https://image.tmdb.org/t/p/w185"
            static let IMG_DEFAULT = "https://lh3.googleusercontent.com/-42o3ibw97tY/AAAAAAAAAAI/AAAAAAAAAE0/mP-wzkDliEQ/photo.jpg"
        }
    }
    
    func searchMovies(Name: String){
    
        let escapedName = Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var sUrl = "https://api.themoviedb.org/3/search/movie?api_key=d8bd7c131fe1670f13c8ee6bb7808fd1&language=en-US&query=" + escapedName!
        let sUrl2 = "&page=1&include_adult=false"
        sUrl = sUrl + sUrl2
        let url = URL(string: sUrl)
        let mainRequest = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: mainRequest, completionHandler: {
            data, response, error in
            
            if let error = error {
                print("Ocurred some error while requesting json: \(error)")
                return
            }
            if let data = data {
            
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                    self.delegate?.didFinishSearchingMovies(json: json)
                }catch let errorMsg {
                    print("Ocurred some error while parsing the json: \(errorMsg)")
                }
                
            }
        })
        task.resume()
        
    }
    
}
