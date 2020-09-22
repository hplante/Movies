//
//  MoviesApp.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-18.
//

import SwiftUI

@main
struct MoviesApp: App {
    let movidbFetcher: MoviedbFetcher
    let moviesDiscoveryViewModel: MoviesDiscoveryViewModel
    let moviesSearchViewModel: MoviesSearchViewModel
    let favoriteMoviesViewModel: FavoriteMoviesViewModel

    init() {
        let movidbFetcher = MoviedbFetcher()
        let moviesDiscoveryViewModel = MoviesDiscoveryViewModel(moviedbFetcher: movidbFetcher)
        self.movidbFetcher = movidbFetcher
        self.moviesDiscoveryViewModel = moviesDiscoveryViewModel
        let moviesSearchViewModel = MoviesSearchViewModel(moviedbFetcher: movidbFetcher)
        self.moviesSearchViewModel = moviesSearchViewModel
        self.favoriteMoviesViewModel = FavoriteMoviesViewModel()
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesDiscoveryView(viewModel: moviesDiscoveryViewModel)
                    .tabItem {
                        Image(systemName: "film.fill")
                        Text("Movies")
                }
                MoviesSearchView(viewModel: moviesSearchViewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                }
                FavoriteMoviesView(viewModel: favoriteMoviesViewModel)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                }
            }
        }
    }
}

