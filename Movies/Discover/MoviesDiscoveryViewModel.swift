//
//  MoviesDiscoveryViewModel.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-20.
//

import SwiftUI
import Combine

class MoviesDiscoveryViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var loading: Bool = false {
        didSet {
            guard loading == true, oldValue != loading else { return }
            fetchMovies()
        }
    }

    private let moviedbFetcher: MoviedbFetchable

    private var page: Int? = nil
    private var disposables = Set<AnyCancellable>()

    init(moviedbFetcher: MoviedbFetchable) {
        self.moviedbFetcher = moviedbFetcher
        fetchMovies()
    }

    func fetchMovies() {
        moviedbFetcher.discoverMovies(page: page)
          .receive(on: DispatchQueue.main)
          .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.movies = []
                case .finished:
                    break
                }
                self.loading = false
            },
            receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.movies = response.movies
            })
          .store(in: &disposables)
    }
}

extension MoviesDiscoveryViewModel {
    static let preview: MoviesDiscoveryViewModel = {
        MoviesDiscoveryViewModel(moviedbFetcher: MoviedbFetcher())
    }()
}
