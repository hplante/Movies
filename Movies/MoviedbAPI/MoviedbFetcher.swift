//
//  MoviedbFetcher.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-02.
//  Copyright © 2020 HPS. All rights reserved.
//

import Combine
import Foundation

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MoviedbError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

protocol MoviedbFetchable {
    func discoverMovies(page: Int?) -> AnyPublisher<MoviesResponse, MoviedbError>
    func searchMovies(query: String, page: Int?) -> AnyPublisher<MoviesResponse, MoviedbError>
}

extension MoviedbFetchable {
    func discoverMovies() -> AnyPublisher<MoviesResponse, MoviedbError> {
        return discoverMovies(page: nil)
    }
    func searchMovies(query: String) -> AnyPublisher<MoviesResponse, MoviedbError> {
        return searchMovies(query: query, page: nil)
    }
}

class MoviedbFetcher {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - MoviedbFetcher
extension MoviedbFetcher: MoviedbFetchable {
    func discoverMovies(page: Int?) -> AnyPublisher<MoviesResponse, MoviedbError> {
        return fetch(with: makeMovieDiscoveryComponents(withPage: page))
    }

    func searchMovies(query: String, page: Int?) -> AnyPublisher<MoviesResponse, MoviedbError> {
        return fetch(with: makeMovieSearchComponents(withQuery: query, page: page))
    }

    private func fetch<T>(with components: URLComponents) -> AnyPublisher<T, MoviedbError> where T: Decodable {
        guard let url = components.url else {
            let error = MoviedbError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Moviedb API
private extension MoviedbFetcher {
    struct MoviedbAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3"
        static let key = Constants.Moviedb.apiKey
    }

    func makeMovieDiscoveryComponents(withPage page: Int?) -> URLComponents {
        var components = URLComponents()
        components.scheme = MoviedbAPI.scheme
        components.host = MoviedbAPI.host
        components.path = MoviedbAPI.path + "/discover/movie"

        var queryItems = [
            URLQueryItem(name: "api_key", value: MoviedbAPI.key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false")
        ]

        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }

        components.queryItems = queryItems

        return components
    }

    func makeMovieSearchComponents(withQuery query: String, page: Int?) -> URLComponents {
        var components = URLComponents()
        components.scheme = MoviedbAPI.scheme
        components.host = MoviedbAPI.host
        components.path = MoviedbAPI.path + "/search/movie"

        var queryItems = [
            URLQueryItem(name: "api_key", value: MoviedbAPI.key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false")
        ]

        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }

        components.queryItems = queryItems

        return components
    }
}
