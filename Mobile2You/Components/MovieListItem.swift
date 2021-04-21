//
//  MovieListItem.swift
//  Mobile2You
//
//  Created by ReisDev on 21/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieListItem: View {
    
    internal let movie: Movie;
    
    internal let imageResizer: SDImageResizingTransformer = SDImageResizingTransformer(size: CGSize(width:60,height: 100), scaleMode: .aspectFill)
    
    @State var checked: Bool = false;
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack{
            WebImage(url: URL(string: movie.posterPath),context: [.imageTransformer: self.imageResizer ])
            VStack(alignment: .leading) {
                Text(movie.title).foregroundColor(.white)
                Text(String(format: "%d",movie.releaseYear))
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }.padding(20)
            Spacer()
            Button(action: { self.checked = !self.checked }) {
                Image("check-circle-solid").resizable().frame(width: 15,height: 15).foregroundColor(checked ? .green : .white)
            }.padding(20)
        }.padding(0)
        .background(Color.black)
        .onTapGesture {
            self.checked = !self.checked
        }
    }
}

/*
 struct MovieListItem_Previews: PreviewProvider {
 static var previews: some View {
 MovieListItem()
 }
 }
 */
