//
//  MoviePresenter.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation
import Alamofire

protocol MoviePresenterDelegate: AnyObject {
    func renderLoading()
    func render(movie: Movie)
}

protocol MoviePresenterProtocol: AnyObject {
    func populate()
}

class MoviePresenter : MoviePresenterProtocol {

    private weak var delegate: MoviePresenterDelegate?
    
    private let movieId = 205596; // Id do filme "O jogo da imitação"
    
    init(delegate: MoviePresenterDelegate) {
        self.delegate = delegate
    }
    
    internal func populate() {
        // TODO: Criar requisição do filme e dos filmes relacionados
        MovieService.shared.getById(id: movieId,onResponse: { [weak self] data in
            var movie: Movie = data;
            MovieService.shared.getSimilarMoviesById(id: self!.movieId, onResponse: { [weak self] movies in
                movie.similarMovies = movies
                self?.delegate?.render(movie: movie)
            })
        })
    }
}
