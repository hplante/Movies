//
//  MoviedbError.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-02.
//  Copyright © 2020 HPS. All rights reserved.
//

import Foundation

enum MoviedbError: Error {
  case parsing(description: String)
  case network(description: String)
}
