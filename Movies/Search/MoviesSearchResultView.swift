//
//  MoviesSearchResultView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import SwiftUI

struct MoviesSearchResultView: View {
    @ObservedObject var urlImageModel: UrlImageModel

    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
        urlImageModel = UrlImageModel(urlString: movie.posterUrl?.absoluteString)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: (urlImageModel.image ?? UIImage(systemName: "film"))!)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .onAppear {
                    self.urlImageModel.loadImage()
                }
            Text(movie.title)
            Spacer()
        }.frame(height: 80)
    }
}

struct MoviesSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesSearchResultView(movie: Movie(id: 42, title: "title", overview: "bla bla bla", posterPath: nil))
    }
}
