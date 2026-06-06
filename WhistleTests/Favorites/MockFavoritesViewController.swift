//
//  MockFavoritesViewController.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import XCTest
@testable import Whistle

class MockFavoritesViewController: FavoritesViewProtocol {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var isError = false
    var reloadFavoritesDataCalled = false
    
    var navigateToDetailsCalled = false
    var lastSelectedSport: Sport?
    var lastSelectedLeagueName: String?
    var lastSelectedLeagueId: Int?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func reloadFavoritesData() {
        reloadFavoritesDataCalled = true
    }
    
    func showError(message: String) {
        isError = true
    }
    
    func navigateToLeagueDetailsScreen(sport: Sport?, leagueName: String, leagueId: Int?) {
        navigateToDetailsCalled = true
        lastSelectedSport = sport
        lastSelectedLeagueName = leagueName
        lastSelectedLeagueId = leagueId
    }
}
