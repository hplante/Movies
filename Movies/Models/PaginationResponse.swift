//
//  PaginationResponse.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-19.
//

import Foundation

protocol PaginationResponse {
    var page: Int? { get }
    var totalResults: Int? { get }
    var totalPages: Int? { get }
}
