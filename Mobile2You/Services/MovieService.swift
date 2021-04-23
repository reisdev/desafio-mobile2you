//
//  MovieService.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation
import Alamofire
import RxSwift

class SimilarMovieResponse: Codable {
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

// Singleton para recuperar os dados dos filmes
class MovieService : Service {
    
    static let shared: MovieService = {
        let instance = MovieService(endpoint: "movie")
        return instance
    }()
    
    func getById(id: Int) -> Observable<Movie> {
        return Observable<Movie>.create { observer in
            let decoder = JSONDecoder()
            let requestUrl = String(format:"%@/%@/%d",self.apiURL,self.endpoint,id);
            let request = AF.request(requestUrl,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: Movie.self, decoder: decoder){ (response) in
                switch response.result {
                case .success(let movie):
                    observer.onNext(movie)
                    observer.onCompleted()
                case .failure:
                    switch response.response!.statusCode {
                    case 401:
                        observer.onError(RequestError.unauthorized)
                    case 404:
                        observer.onError(RequestError.notFound)
                    case 500...503:
                        observer.onError(RequestError.serverUnavailable)
                    default:
                        observer.onError(RequestError.unknown)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getSimilarMoviesById(id: Int) -> Observable<[Movie]> {
        return Observable<[Movie]>.create { observer in
            let decoder = JSONDecoder()
            let requestUrl = String(format:"%@/%@/%d/similar",self.apiURL,self.endpoint,id)
            let request = AF.request(requestUrl ,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: SimilarMovieResponse.self,decoder: decoder){ (response) in
                switch response.result {
                case .success(let movies):
                    observer.onNext(movies.results)
                    observer.onCompleted()
                case .failure:
                    switch response.response!.statusCode {
                    case 401:
                        observer.onError(RequestError.unauthorized)
                    case 404:
                        observer.onError(RequestError.notFound)
                    case 500...503:
                        observer.onError(RequestError.serverUnavailable)
                    default:
                        observer.onError(RequestError.unknown)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
