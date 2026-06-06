
//
//  LocalServices.swift
//  Whistle
//
//  Created by Ahmed Nageh on 01/06/2026.
//

import Foundation

protocol LocalServicesProtocol {
    func saveFavorite(league: League , sportType: Sport)
    func fetchAllFavorites() -> [FavoriteLeague]
    func deleteFavorite(leagueKey: Int)
    func isFavorite(leagueKey: Int?) -> Bool
}

class LocalServices: LocalServicesProtocol {
    
    private let databaseManager: CoreDataManagerProtocol
        
    init(databaseManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.databaseManager = databaseManager
    }
    
    func saveFavorite(league: League ,sportType: Sport) {
        databaseManager.saveFavoriteLeague(league: league, sportType: sportType)
    }
    
    func fetchAllFavorites() -> [FavoriteLeague] {
        return databaseManager.fetchAllFavorites()
    }
    
    func deleteFavorite(leagueKey: Int) {
        databaseManager.deleteFavoriteLeague(leagueKey: leagueKey)
    }
    
    func isFavorite(leagueKey: Int?) -> Bool {
        return databaseManager.isLeagueFavorite(leagueKey: leagueKey)
    }
}
