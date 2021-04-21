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
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack{() -> AnyView in
                    switch store.state {
                    case .loading:
                        return AnyView(
                            ProgressView().scaleEffect(2,anchor: .center))
                    case .loaded(let movie):
                        return (AnyView(
                            MovieDetails(movie: movie)
                        ))
                    }
                }
                Spacer()
            }.onAppear(perform: self.presenter.populate)
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
        }.frame(height: UIScreen.main.bounds.height)
        .edgesIgnoringSafeArea([.top,.bottom])
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(store: MovieStore())
    }
}
