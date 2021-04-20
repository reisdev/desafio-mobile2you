//
//  MoviePresenter.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import Foundation

protocol MoviesPresenterProtocol {
    init(interactor: MoviesInteractor)
    var movie: Movie! { get };
    var similarMovies: [Movie] {get }
}

final class MoviesPresenter : MoviesPresenterProtocol, ObservableObject {

    var movie: Movie! = nil;
    var similarMovies: [Movie] = [];

    private let interactor: MoviesInteractor;
    private let movieId = 205596; // Id do filme "O jogo da imitação"
    
    init(interactor: MoviesInteractor) {
        self.interactor = interactor;
    }
    
    internal func populate() {
        // TODO: Criar requisição do filme e dos filmes relacionados
    }
}
