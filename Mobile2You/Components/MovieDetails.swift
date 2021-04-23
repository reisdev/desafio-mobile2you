//
//  MovieDetails.swift
//  Mobile2You
//
//  Created by ReisDev on 21/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetails: View {
    
    let movie: Movie;
    @State private var liked: Bool = false;
    
    internal var LikeImage: Image {
        get {
            return liked ? Image("heart-solid") : Image("heart-regular")
        }
    }
    internal let imageResizer: SDImageResizingTransformer = SDImageResizingTransformer(size: CGSize(width:UIScreen.main.bounds.width,height: 350), scaleMode: .aspectFill)
    internal let imageEffect: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color.black,Color.clear]),
                                                              startPoint: .center, endPoint: .bottom)
    
    init(movie: Movie){
        self.movie = movie;
    }
    
    internal func toggleLike(){
        self.liked = !self.liked
    }
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: self.movie.posterPath),
                     context: [.imageTransformer: imageResizer])
                .mask(self.imageEffect)
            HStack(spacing: 20) {
                Text(self.movie.title).foregroundColor(.white)
                    .font(.system(size: 24))
                    .fontWeight(.black)
                    .padding(.leading, 20)
                Spacer()
                Button(action: self.toggleLike) {
                    LikeImage.resizable()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                }
            }
            HStack(alignment: .firstTextBaseline) {
                HStack{
                    Image("heart-solid").resizable()
                        .frame(width: 15,height: 15)
                        .foregroundColor(.white)
                    Text(String(format: "%@ Likes",movie.voteCount.formatToK()))
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                HStack{
                    Image("fire-alt-solid").resizable()
                        .frame(width: 15,height: 15)
                        .foregroundColor(.white)
                    Text(String(format: "%d Views",movie.popularity))
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }.padding(.leading,20)
                Spacer()
            }.padding(.horizontal,20)
        }.padding(.bottom,20)
    }
}

/*
 struct MovieDetails_Previews: PreviewProvider {
 static var previews: some View {
 MovieDetails()
 }
 }*/
