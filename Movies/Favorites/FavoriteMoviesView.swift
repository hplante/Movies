//
//  FavoriteMoviesView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//


import SwiftUI

struct FavoriteMoviesView: View {
    @ObservedObject var viewModel: FavoriteMoviesViewModel

    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView() {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))) {
                            MoviesGridView(movie: movie)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Favorite Movies"), displayMode: .inline)
        }
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView(viewModel: FavoriteMoviesViewModel.preview)
    }
}
