//
//  MovieModel.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation

struct Genre: Codable {
    var id: Int;
    var name: String;
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case name = "name"
    }
}

struct Movie: Codable {
    var id: Int;
    var overview: String
    var popularity: Double
    var title: String
    var voteCount: Int
    var poster_path: String;
    var releaseDate: String;
    var similarMovies: [Movie];
    var genres: [Genre];
    var genre_ids: [Int];
    var releaseYear: Int {
        get {
            return Int(releaseDate.split(separator: "-")[0]) ?? 0
        }
    }
    
    var posterPath: String {
        // Resolve a URL da imagem
        get {
            return String(format:"%@%@","https://image.tmdb.org/t/p/w500",self.poster_path) }
        set(path) {
            self.poster_path = path
        }
    };
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case overview = "overview"
        case popularity = "popularity"
        case title = "title"
        case voteCount = "vote_count"
        case poster_path = "poster_path"
        case genres = "genres"
        case genre_ids = "genre_ids"
        case releaseDate = "release_date"
        case similarMovies
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id )
        overview = try values.decode(String.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        title = try values.decode(String.self,forKey: .title)
        voteCount = try values.decode(Int.self,forKey: .voteCount)
        poster_path = try values.decode(String.self,forKey: .poster_path)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        if(values.contains(.genres)) {
            genres = try values.decode([Genre].self,forKey: .genres)
        }
        else {
            genres = []
        }
        if (values.contains(.genre_ids)) {
            genre_ids = try values.decode([Int].self,forKey: .genre_ids)
        } else {
            genre_ids = []
        }
        similarMovies = []
    }
    
    // Retorna as 3 primeiras categorias por ordem alfabética, separadas por vírgula
    func genresToString() -> String {
        let limit = min(genres.count,3)
        return String(format: "%@",genres.sorted{ $0.name < $1.name }[0..<limit].map{$0.name}
                        .reduce("",{$0 == "" ? $1 : "\($0), \($1)" }))
    }
}

class MovieViewModel {
    var movie: Movie;
    var similarMovies: [Movie]
    var genres: Dictionary<Int,String>
    
    init(movie: Movie, similarMovies: [Movie],genres: Dictionary<Int,String>) {
        self.movie = movie
        self.similarMovies = similarMovies
        self.genres = genres
    }
}

class MovieStore: ObservableObject {
    enum State {
        case loading
        case loaded(data: MovieViewModel)
    }
    @Published var state: State = .loading
}

extension MovieStore: MoviePresenterDelegate {
    func render(data: MovieViewModel) {
        self.state = .loaded(data: data)
    }
    func renderLoading(){
        self.state = .loading
    }
}

// Para formatar os likes e views com "000.0K"
extension Int {
    func formatToK() -> String {
        let num = self > 1000 ? Double(self)/1000.0 : Double(self)
        return String(format: self >= 1000 ? "%.1fK" : "%.0f",num)
    }
}
