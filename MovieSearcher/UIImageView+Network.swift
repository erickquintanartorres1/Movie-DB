//
//  UIImageView+Network.swift
//  MovieSearcher
//
//  Created by Erick Torres on 4/27/17.
//  Copyright © 2017 Erick Torres. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func downloadImageFrom(url: String){
    
        let Url = URL(string: url)
        let session = URLSession.shared
        let task = session.dataTask(with: Url!, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    self.downloadImageFrom(url: NetworkManager.Globals.URLs.IMG_DEFAULT)
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        task.resume()
    }

}
