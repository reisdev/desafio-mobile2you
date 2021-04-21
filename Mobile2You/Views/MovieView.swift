//
//  MovieView.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieView: View {
    
    var presenter: MoviePresenter;
    @ObservedObject var store: MovieStore;
    
    init(store: MovieStore){
        self.presenter = MoviePresenter(delegate: store)
        self.store = store
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack {
                VStack(alignment: .leading) {
                    VStack{() -> AnyView in
                        switch store.state {
                        case .loading:
                            return AnyView(
                                ProgressView().scaleEffect(2,anchor: .center))
                        case .loaded(let movie):
                            return (AnyView(
                                ScrollView(showsIndicators: false) {
                                    MovieDetails(movie: movie)
                                    ForEach(movie.similarMovies,id: \.id) { movie in MovieListItem(movie: movie)
                                    }.background(Color.black)
                                }.edgesIgnoringSafeArea(.all)
                            ))
                        }
                    }
                    Spacer()
                }
            }.background(Color.black)
        }.navigationBarTitle("",displayMode: .inline)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear(perform: self.presenter.populate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(store: MovieStore())
    }
}
