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
class GenreService: Service {
    
    static let shared: GenreService = {
        let instance = GenreService(endpoint: "genre")
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
