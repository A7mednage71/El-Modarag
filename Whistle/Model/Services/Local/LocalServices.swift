
//
//  LocalServices.swift
//  Whistle
//
//  Created by Ahmed Nageh on 01/06/2026.
//

import Foundation

protocol LocalServicesProtocol {
    static func saveFavorite(league: League)
    static func fetchAllFavorites() -> [League]
    static func deleteFavorite(leagueKey: Int)
    static func isFavorite(leagueKey: Int?) -> Bool
}

class LocalServices: LocalServicesProtocol {
    
    static func saveFavorite(league: League) {
        CoreDataManager.shared.saveFavoriteLeague(league: league)
    }
    
    static func fetchAllFavorites() -> [League] {
        return CoreDataManager.shared.fetchAllFavorites()
    }
    
    static func deleteFavorite(leagueKey: Int) {
        CoreDataManager.shared.deleteFavoriteLeague(leagueKey: leagueKey)
    }
    
    static func isFavorite(leagueKey: Int?) -> Bool {
        return CoreDataManager.shared.isLeagueFavorite(leagueKey: leagueKey)
    }
}
