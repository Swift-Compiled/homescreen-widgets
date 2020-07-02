//
//  MovieUpdater.swift
//  iOS
//
//  Created by Alex Brown on 30/06/2020.
//

import Foundation

class MovieUpdater {
    var movie: Movie = Movie.empty
    var timer: Timer? = nil
    var movies: [Movie] = [
        Movie(name: "Avengers: Infinity War",
              movieImageName: "infinity"),
        Movie(name: "Avengers: End Game",
              movieImageName: "endgame"),
        Movie(name: "Guardians of the Galaxy Volume 3", 
                movieImageName: "gog3")
    ]
    
    init() {
        self.getNextMovie()
        self.timer = Timer.scheduledTimer(withTimeInterval: 10,
                                          repeats: true,
                                          block: { [weak self] (timer) in
            self?.getNextMovie()
        })
    }
    
    func getNextMovie() {
        let range = (0...movies.count - 1)
        let randomIndexInRange = Int.random(in: range)
        self.movie = movies[randomIndexInRange]
    }
}
