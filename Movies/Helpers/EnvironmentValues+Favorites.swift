//
//  EnvironmentValues+Favorites.swift
//  Movies
//
//  Created by Hugo Plante on 2020-09-21.
//

import SwiftUI

struct FavoritesKey: EnvironmentKey {
    static let defaultValue: Favorites = Favorites()
}

extension EnvironmentValues {
    var favorites: Favorites {
        get { self[FavoritesKey.self] }
        set { self[FavoritesKey.self] = newValue }
    }
}
