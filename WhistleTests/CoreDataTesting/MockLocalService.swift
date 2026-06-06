//
//  MockLocalService.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
@testable import Whistle

class MockLocalService: LocalServicesProtocol {
    
    var favoriteLeagueKeys: [Int] = []
    
    var savedLeagues: [League] = []
    
    func saveFavorite(league: League, sportType: Sport) {
        if let key = league.leagueKey {
            favoriteLeagueKeys.append(key)
            savedLeagues.append(league)
        }
    }
    
    func fetchAllFavorites() -> [FavoriteLeague] {
        return savedLeagues.map { league in
            FavoriteLeague(
                leagueKey: league.leagueKey ?? 0,
                leagueName: league.leagueName,
                leagueLogo: league.leagueLogo,
                countryName: league.countryName,
                sportType: "football"
            )
        }
    }
    
    func deleteFavorite(leagueKey: Int) {
        favoriteLeagueKeys.removeAll { $0 == leagueKey }
        savedLeagues.removeAll { $0.leagueKey == leagueKey }
    }
    
    func isFavorite(leagueKey: Int?) -> Bool {
        guard let key = leagueKey else { return false }
        return favoriteLeagueKeys.contains(key)
    }
}
