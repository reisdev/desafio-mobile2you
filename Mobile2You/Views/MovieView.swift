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
    
    let imageResizer: SDImageResizingTransformer = SDImageResizingTransformer(size: CGSize(width:UIScreen.main.bounds.width,height: 350), scaleMode: .aspectFill)
    
    init(store: MovieStore){
        self.presenter = MoviePresenter(delegate: store)
        self.store = store
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
    
    internal func getImageUrl(path: String) -> String {
        return String(format:"%@%@","https://image.tmdb.org/t/p/w500",path)
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                VStack{() -> AnyView in
                    switch store.state {
                    case .loading:
                        return AnyView(
                            ProgressView().scaleEffect(2,anchor: .center))
                    case .loaded(let movie):
                        return (AnyView(
                            WebImage(url: URL(string: getImageUrl(path: movie.posterPath)),
                                     context: [.imageTransformer: imageResizer])
                                .mask(LinearGradient(gradient: Gradient(colors: [Color.black,Color.clear]),
                                                     startPoint: .center, endPoint: .bottom))
                        ))
                    }
                }
                Spacer()
            }.onAppear(perform: self.presenter.populate)
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(store: MovieStore())
    }
}
