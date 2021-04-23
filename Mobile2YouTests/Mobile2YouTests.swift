//
//  Mobile2YouTests.swift
//  Mobile2YouTests
//
//  Created by ReisDev on 19/04/21.
//

import XCTest
import RxSwift
@testable import Mobile2You

class Mobile2YouTests: XCTestCase {
    
    var movie: Movie!
    var disposeBag: DisposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.movie = Movie(id: 1, title: "Test Movie", overview: "example", popularity: 0.0, voteCount: 0,poster_path: "/testimage.png", releaseDate: "2021-04-21", genres: [Genre(id: 1, name: "Action"),Genre(id: 2, name: "Adventure"),Genre(id: 3, name: "Science Fiction")],genre_ids:[])
        
    }
    
    override func tearDownWithError() throws {
        self.movie = nil
    }
    
    func testMovieModel() throws {
        XCTAssertEqual(self.movie.releaseYear,2021,".releaseYear computed property returns the correct year")
        XCTAssertEqual(self.movie.posterPath,"https://image.tmdb.org/t/p/w500/testimage.png",".posterPath computed property returns the correct image source URL")
        XCTAssertEqual(self.movie.genresToString(),"Action, Adventure, Science Fiction",".genresToString return the genres formatted correctly")
    }
    
    func testMovieService() throws {
        
        MovieService.shared.getById(id: 11).subscribe(onNext: { movie in
            XCTAssertEqual(movie.title,"Star Wars",".getById method return the right source")
        },onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.notFound.localizedDescription,".getById fails when resource doesn't exist")
        }).disposed(by: self.disposeBag)
        
        MovieService.shared.getSimilarMoviesById(id: 11).subscribe(onNext: { movies in
            XCTAssertGreaterThanOrEqual(movies.count,0,".getSimilarMoviesById method return the list of related movies")
        },onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.notFound.localizedDescription,".getSimilarMoviesById fails when API_KEY is not set")
        }).disposed(by: self.disposeBag)
        
        MovieService.shared.getById(id: 1).subscribe(onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.notFound.localizedDescription,".getById fails when resource doesn't exist")
        }).disposed(by: self.disposeBag)
        
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        
        setenv("API_KEY","",1)
        MovieService.shared.getById(id: 11).subscribe(onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.unauthorized.localizedDescription,".getById fails when API_KEY is not set")
        }).disposed(by: self.disposeBag)
        
        MovieService.shared.getSimilarMoviesById(id: 11).subscribe(onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.notFound.localizedDescription,".getSimilarMoviesById fails when resource doesn't exist")
        }).disposed(by: self.disposeBag)
        setenv("API_KEY",apiKey ?? "",1)
    }
    
    func testGenreService() throws {
        GenreService.shared.getGenresList().subscribe(onNext: { genres in
            XCTAssertGreaterThanOrEqual(genres.count,0,".getGenresList returns a list")
        }).disposed(by: self.disposeBag)
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        setenv("API_KEY","",1)
        GenreService.shared.getGenresList().subscribe(onError: { error in
            XCTAssertEqual(error.localizedDescription,RequestError.unauthorized.localizedDescription,".getGenresList fails when API_KEY is not set")
        }).disposed(by: self.disposeBag)
        setenv("API_KEY",apiKey ?? "",1)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
