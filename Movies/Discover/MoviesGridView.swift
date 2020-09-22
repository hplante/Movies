//
//  MovieGridView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-20.
//

import SwiftUI

struct MoviesGridView: View {
    @ObservedObject var urlImageModel: UrlImageModel

    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
        urlImageModel = UrlImageModel(urlString: movie.posterUrl?.absoluteString)
    }

    var body: some View {
        VStack {
            Image(uiImage: (urlImageModel.image ?? UIImage(systemName: "film"))!)
                .resizable()
                .scaledToFit()
                .onAppear {
                    self.urlImageModel.loadImage()
                }
            Text(movie.title)
        }
    }
}

struct MoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesGridView(movie: Movie(id: 42, title: "title", overview: "bla bla bla", posterPath: ""))
    }
}
