//
//  Favorites.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import SwiftUI

class Favorites: ObservableObject {
    @Published var favorites: [Movie] = []

    func isFavorite(movie: Movie) -> Bool {
        return favorites.contains(movie)
    }

    func fav(movie: Movie) {
        favorites.append(movie)
    }

    func unfav(movie: Movie) {
        favorites.removeAll(where: {$0.id == movie.id} )
    }
}
