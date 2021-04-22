//
//  GerneService.swift
//  Mobile2You
//
//  Created by ReisDev on 21/04/21.
//

import Foundation
import Alamofire
import RxSwift

struct GenreResponse: Codable {
    var genres: [Genre]
}

//Singleton para recuperar os gêneros
class GenreService {
    
    var apiURL : String = "https://api.themoviedb.org/3";
    var endpoint: String = "genre"
    var apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "";
    
    static let shared: GenreService = {
        let instance = GenreService()
        return instance
    }()
    
    func getGenresList () -> Observable<[Genre]>{
        return Observable.create { observer in
            let requestUrl = String(format: "%@/%@/%@",self.apiURL,self.endpoint,"movie/list")
            let decoder = JSONDecoder()
            let request = AF.request(requestUrl,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: GenreResponse.self, decoder: decoder) {(response) in
                switch response.result {
                case .success(let result):
                    observer.onNext(result.genres)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
        
    }
    
}
