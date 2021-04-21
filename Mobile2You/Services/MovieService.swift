//
//  MovieService.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation
import Alamofire

// Singleton para recuperar os dados dos filmes
class MovieService {
      
    var apiURL : String = "https://api.themoviedb.org/3";
    var endpoint: String = "movie"
    var apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "";
    
    static let shared: MovieService = {
        let instance = MovieService()
        return instance
    }()
    
    func getById(id: Int, onResponse: @escaping (Movie) -> Void) {
        let decoder = JSONDecoder()
        let requestUrl = String(format:"%@/%@/%d",self.apiURL,self.endpoint,id);
        AF.request(requestUrl,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: Movie.self, decoder: decoder){ (response) in
            switch response.result {
                case .success(let movie):
                    onResponse(movie)
                case .failure:
                    debugPrint("Error")
            }
        }
    }
    
    func getSimilarMoviesById(id: Int, onResponse: @escaping ([Movie]) -> Void) {
        let decoder = JSONDecoder()
        let requestUrl = String(format:"%@/%@/%d/similar",self.apiURL,self.endpoint,id)
        AF.request(requestUrl ,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: SimilarMovieResponse.self,decoder: decoder){ (response) in
            switch response.result {
                case .success(let movies):
                    onResponse(movies.results)
                case .failure(let message):
                    debugPrint(message)
            }
        }
    }
}
