//
//  MoviePresenter.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation
import Alamofire
import RxSwift

protocol MoviePresenterDelegate: AnyObject {
    func renderLoading()
    func render(data: MovieViewModel)
}

protocol MoviePresenterProtocol: AnyObject {
    func populate()
}

class MoviePresenter : MoviePresenterProtocol {
    
    private weak var delegate: MoviePresenterDelegate?
    
    private let movieId = 205596; // Id do filme "O jogo da imitação"
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(delegate: MoviePresenterDelegate) {
        self.delegate = delegate
    }
    
    internal func populate() {
        // TODO: Criar requisição do filme e dos filmes relacionados
        
        MovieService.shared.getById(id: self.movieId)
            .subscribe(onNext: { [self] movie in
                MovieService.shared.getSimilarMoviesById(id: movieId)
                    .subscribe(onNext: { [self] movies in
                        GenreService.shared.getGenresList().subscribe(onNext: { [self] genres in
                            var dict = Dictionary<Int,String>()
                            genres.forEach { dict[$0.id] = $0.name }
                            self.delegate?.render(data: MovieViewModel(movie: movie, similarMovies: movies, genres: dict))
                        }).disposed(by: self.disposeBag)
                    }).disposed(by: self.disposeBag)
            }).disposed(by: self.disposeBag)
        
    }
}
