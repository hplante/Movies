//
//  FavoriteMoviesViewModel.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-22.
//

import Combine
import SwiftUI

class FavoriteMoviesViewModel: ObservableObject {
    @Environment(\.favorites) var favorites: Favorites

    @Published var movies: [Movie] = [Movie]()

    private var disposables = [AnyCancellable]()

    init() {
        favorites.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.movies = self?.favorites.favorites ?? [Movie]()
            }
            .store(in: &disposables)
    }
}

extension FavoriteMoviesViewModel {
    static let preview: FavoriteMoviesViewModel = {
        FavoriteMoviesViewModel()
    }()
}

