//
//  MoviesDiscoveryView.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-20.
//

import SwiftUI

struct MoviesDiscoveryView: View {
    @StateObject var viewModel: MoviesDiscoveryViewModel

    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            RefreshableScrollView(refreshing: $viewModel.loading) {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))) {
                            MoviesGridView(movie: movie)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Popular Movies"), displayMode: .inline)
        }
    }
}

struct MoviesDiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesDiscoveryView(viewModel: MoviesDiscoveryViewModel.preview)
    }
}
