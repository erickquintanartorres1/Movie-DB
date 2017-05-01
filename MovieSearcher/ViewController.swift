//
//  ViewController.swift
//  MovieSearcher
//
//  Created by Erick Torres on 4/27/17.
//  Copyright © 2017 Erick Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NetworkManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!

    let netManager = NetworkManager()
    var movieList = [Movie]()
    var selectedMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        netManager.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            movieList.removeAll()
            netManager.searchMovies(Name: searchText)
        }
    }
    
    func didFinishSearchingMovies(json: [String : Any]) {
        let movies = json["results"] as! [[String: Any]]
        for movie in movies {
            movieList.append(Movie.parseFrom(json: movie))
        }
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieCollectionViewCell
        
        let currentMovie = movieList[indexPath.row]
        cell.imageView.downloadImageFrom(url: NetworkManager.Globals.URLs.IMG + currentMovie.posterPath)
        cell.titleLabel.text = currentMovie.originalTitle
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedMovie = movieList[indexPath.row]
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailsViewController
        destination.currentMovie = self.selectedMovie
    }

}

