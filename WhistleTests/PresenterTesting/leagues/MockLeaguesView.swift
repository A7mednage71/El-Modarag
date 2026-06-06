//
//  MockLeaguesView.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
@testable import Whistle

class MockLeaguesView: LeaguesViewProtocol {
    
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var isReloadLeaguesDataCalled = false
    
    var errorMessage: String?
    var navigatedSport: Sport?
    var navigatedLeagueName: String?
    var navigatedLeagueId: Int?
    
    func showLoading() { isShowLoadingCalled = true }
    func hideLoading() { isHideLoadingCalled = true }
    func reloadLeaguesData() { isReloadLeaguesDataCalled = true }
    func showError(message: String) { errorMessage = message }
    
    func navigateToLeaguesScreen(sport: Sport, leagueName: String, leagueId: Int?) {
        navigatedSport = sport
        navigatedLeagueName = leagueName
        navigatedLeagueId = leagueId
    }
}
