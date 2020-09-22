//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-20.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    @ObservedObject var viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        urlImageModel = UrlImageModel(urlString: viewModel.movie.posterUrl?.absoluteString)
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: (urlImageModel.image ?? UIImage(systemName: "film"))!)
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        self.urlImageModel.loadImage()
                    }
                Text(viewModel.movie.title).font(.title).padding(.bottom)
                Text(viewModel.movie.overview).font(.body)
            }
            .padding([.leading,.trailing])
        }
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    viewModel.toggle()
                }) {
                    if viewModel.isFavorite {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
            }
        )
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(movie: Movie(id: 42, title: "title", overview: "bla bla", posterPath: nil)))
    }
}
