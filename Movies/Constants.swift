//
//  Constants.swift
//  Youtube
//
//  Created by Hugo Plante on 2020-09-02.
//  Copyright © 2020 HPS. All rights reserved.
//

import Foundation

enum Constants {

    enum Moviedb {
        static let apiKey = Bundle.main.infoDictionary?["MOVIEDB_API_KEY"] as? String
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    }
}
