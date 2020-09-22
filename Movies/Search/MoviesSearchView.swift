//
//  MoviesSearchView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import SwiftUI

struct MoviesSearchView: View {
    @StateObject var viewModel: MoviesSearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText).padding()
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))) {
                                MoviesSearchResultView(movie: movie)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Search Movies"), displayMode: .inline)
        }
    }
}

struct MoviesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesSearchView(viewModel: MoviesSearchViewModel.preview)
    }
}
