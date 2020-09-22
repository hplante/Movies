//
//  MoviesSearchViewModel.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import SwiftUI
import Combine

class MoviesSearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""

    private let moviedbFetcher: MoviedbFetchable
    private var queryParam: AnyPublisher<String, Never> {
        $searchText
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .eraseToAnyPublisher()
      }

    private var page: Int? = nil
    private var disposables = Set<AnyCancellable>()

    init(moviedbFetcher: MoviedbFetchable) {
        self.moviedbFetcher = moviedbFetcher

        queryParam
            .receive(on: DispatchQueue.main)
            .sink(
                receiveValue: { [weak self] value in
                    if !value.isEmpty {
                        self?.searchMovies(searchText: value)
                    }
                }
            )
            .store(in: &disposables)
    }

    func searchMovies(searchText: String) {
        moviedbFetcher.searchMovies(query: searchText, page: page)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.movies = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.movies = response.movies
                })
            .store(in: &disposables)
    }
}

extension MoviesSearchViewModel {
    static let preview: MoviesSearchViewModel = {
        MoviesSearchViewModel(moviedbFetcher: MoviedbFetcher())
    }()
}

