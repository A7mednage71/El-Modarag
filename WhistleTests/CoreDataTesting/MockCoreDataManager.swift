//
//  MockCoreDataManager.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
import XCTest
@testable import Whistle


class MockCoreDataManager: CoreDataManagerProtocol {
    
    var savedLeagues: [Int: League] = [:]
    
    var isSaveCalled = false
    
    var isDeleteCalled = false
    
    func saveFavoriteLeague(league: League, sportType: Sport) {
        isSaveCalled = true
        savedLeagues[league.leagueKey ?? 0] = league
    }
    
    func fetchAllFavorites() -> [FavoriteLeague] {
        return savedLeagues.values.map {
            FavoriteLeague(leagueKey: $0.leagueKey ?? 0, leagueName: $0.leagueName, leagueLogo: nil, countryName: $0.countryName, sportType: "football")
        }
    }
    
    func deleteFavoriteLeague(leagueKey: Int) {
        isDeleteCalled = true
        savedLeagues.removeValue(forKey: leagueKey)
    }
    
    func isLeagueFavorite(leagueKey: Int?) -> Bool {
        return savedLeagues[leagueKey ?? 0] != nil
    }
}
