//
//  MovieModel.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation

struct Movie: Codable {
    var overview: String
    var popularity: Double
    var title: String
    var vote_count: Int
    var poster_path: String;
}

protocol MoviesInteractorProtocol {
    static func getById(id: Int)
    static func getSimilarMoviesById(id: Int)
}

struct MoviesInteractor : MoviesInteractorProtocol {
    static func getById(id: Int) {
        
    }
    static func getSimilarMoviesById(id: Int) {
        
    }
}
