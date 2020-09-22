//
//  DiscoverMovieResponse.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-19.
//

import Foundation

struct MoviesResponse: Decodable, PaginationResponse {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
