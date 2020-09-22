//
//  Movie.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-19.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

extension Movie {
    var posterUrl: URL? {
        guard let posterPath = posterPath, let baseUrl = URL(string: Constants.Moviedb.imageBaseUrl) else { return nil }
        return baseUrl.appendingPathComponent(posterPath)
    }
}
