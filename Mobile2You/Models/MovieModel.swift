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
    var voteCount: Int
    var posterPath: String;
    var similarMovies: [Movie];
    
    enum CodingKeys: String,CodingKey {
        case overview = "overview"
        case popularity = "popularity"
        case title = "title"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case similarMovies
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        overview = try values.decode(String.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        title = try values.decode(String.self,forKey: .title)
        voteCount = try values.decode(Int.self,forKey: .voteCount)
        posterPath = try values.decode(String.self,forKey: .posterPath)
        similarMovies = []
    }
}

struct SimilarMovieResponse: Codable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalCount: Int
    
    enum CodingKeys: String,CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalCount = "total_results"
    }
}

class MovieStore: ObservableObject {
    enum State {
        case loading
        case loaded(movie: Movie)
    }
    @Published var state: State = .loading
}

extension MovieStore: MoviePresenterDelegate {
    func render(movie: Movie) {
        self.state = .loaded(movie: movie)
    }
    func renderLoading(){
        self.state = .loading
    }
}
