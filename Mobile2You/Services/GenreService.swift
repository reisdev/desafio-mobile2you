//
//  GerneService.swift
//  Mobile2You
//
//  Created by ReisDev on 21/04/21.
//

import Foundation
import Alamofire

//Singleton para recuperar os gêneros
class GenreService {
      
    var apiURL : String = "https://api.themoviedb.org/3";
    var endpoint: String = "genre"
    var apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "";
    
    static let shared: GenreService = {
        let instance = GenreService()
        return instance
    }()
    
    func getGenresList (onResponse: @escaping ([Genre]) -> Void){
        let requestUrl = String(format: "%@/%@/%@",self.apiURL,self.endpoint,"movie/list")
        let decoder = JSONDecoder()
        AF.request(requestUrl,parameters: ["api_key": self.apiKey], encoding: URLEncoding(destination: .queryString)).responseDecodable(of: [Genre].self, decoder: decoder) {(response) in
            switch response.result {
                case .success(let genres):
                    onResponse(genres)
                case .failure:
                    debugPrint("Error")
            }
        }
        
    }
    
}
