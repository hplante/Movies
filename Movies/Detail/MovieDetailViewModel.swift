//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import Combine
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    @Environment(\.favorites) var favorites: Favorites
    
    @Published var isFavorite: Bool = false

    let movie: Movie

    private var disposables = [AnyCancellable]()

    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = favorites.isFavorite(movie: movie)
        favorites.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.isFavorite = strongSelf.favorites.isFavorite(movie: movie)
            }
            .store(in: &disposables)
    }

    func toggle() {
        isFavorite.toggle()

        if isFavorite {
            favorites.fav(movie: movie)
        } else {
            favorites.unfav(movie: movie)
        }
    }
}
