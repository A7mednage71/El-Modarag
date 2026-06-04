
//
//  LocalServices.swift
//  Whistle
//
//  Created by Ahmed Nageh on 01/06/2026.
//

import Foundation

protocol LocalServicesProtocol {
    static func saveFavorite(league: League , sportType: Sport)
    static func fetchAllFavorites() -> [FavoriteLeague]
    static func deleteFavorite(leagueKey: Int)
    static func isFavorite(leagueKey: Int?) -> Bool
}

class LocalServices: LocalServicesProtocol {
    
    static func saveFavorite(league: League ,sportType: Sport) {
        CoreDataManager.shared.saveFavoriteLeague(league: league, sportType: sportType)
    }
    
    static func fetchAllFavorites() -> [FavoriteLeague] {
        return CoreDataManager.shared.fetchAllFavorites()
    }
    
    static func deleteFavorite(leagueKey: Int) {
        CoreDataManager.shared.deleteFavoriteLeague(leagueKey: leagueKey)
    }
    
    static func isFavorite(leagueKey: Int?) -> Bool {
        return CoreDataManager.shared.isLeagueFavorite(leagueKey: leagueKey)
    }
}
