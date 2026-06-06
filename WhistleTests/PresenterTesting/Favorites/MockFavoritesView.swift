//
//  MockFavoritesView.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
@testable import Whistle

class MockFavoritesView: FavoritesViewProtocol {
    
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var isReloadFavoritesDataCalled = false
    var navigatedSport: Sport?
    var navigatedLeagueName: String?
    var navigatedLeagueId: Int?
    
    func showError(message: String) {
        
    }
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func hideLoading() {
        isHideLoadingCalled = true
    }
    
    func reloadFavoritesData() {
        isReloadFavoritesDataCalled = true
    }
    
    func navigateToLeagueDetailsScreen(sport: Sport?, leagueName: String, leagueId: Int?) {
        navigatedSport = sport
        navigatedLeagueName = leagueName
        navigatedLeagueId = leagueId
    }
}
