//
//  FavoritesStorage.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import Foundation

class FavoriteStorage {
    
    static let shared = FavoriteStorage()
    private let favoritesKey = "favorite-cities"
    
    func addFavorite(city: City) {
        var favorites = getAllFovorites()
        if !favorites.contains(where: { $0.woeid == city.woeid }) {
            favorites.append(city)
        }
        
        saveFavorites(cities: favorites)
    }
    
    func getAllFovorites() -> [City] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return [City]()
        }
        
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            return cities
        } catch {
            return [City]()
        }
        
    }
    
    private func saveFavorites(cities: [City]) {
        do {
            let data = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            
        }
    }
    
    func removeFavorite(city: City) {
        var favorites = getAllFovorites()
        favorites.removeAll(where: { $0.woeid == city.woeid })
            
        saveFavorites(cities: favorites)
        
    }
    
    func isAFavorite(city: City) -> Bool {
        let favorites = getAllFovorites()
        if favorites.contains(where: { $0.woeid == city.woeid }) {
            return true
        } else {
            return false
        }
        
    }
    
}

