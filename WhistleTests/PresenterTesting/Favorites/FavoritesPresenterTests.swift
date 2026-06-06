//
//  FavoritesPresenterTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
import XCTest
@testable import Whistle

class FavoritesPresenterTests: XCTestCase {
    
    var sut: FavoritesPresenter!
    var mockView: MockFavoritesView!
    var mockLocal: MockLocalService!
    
    override func setUp() {
        super.setUp()
        mockView = MockFavoritesView()
        mockLocal = MockLocalService()
        sut = FavoritesPresenter(view: mockView, localService: mockLocal)
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockLocal = nil
        super.tearDown()
    }
    
    
    func testViewDidLoad_PopulatesFavoritesAndRefreshesView() {
        let dummyLeague = League(leagueKey: 10, leagueName: "EPL", leagueLogo: nil, countryName: "England")
        mockLocal.saveFavorite(league: dummyLeague, sportType: .football)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockView.isShowLoadingCalled)
        XCTAssertTrue(mockView.isHideLoadingCalled)
        XCTAssertTrue(mockView.isReloadFavoritesDataCalled)
        XCTAssertEqual(sut.numberOfFavorites, 1)
        XCTAssertEqual(sut.favoriteItem(at: 0).leagueName, "EPL")
    }
    
    
    func testDidRemoveFavorite_DeletesFromStorageAndUpdatesList() {
        let dummyLeague = League(leagueKey: 20, leagueName: "La Liga", leagueLogo: nil, countryName: "Spain")
        mockLocal.saveFavorite(league: dummyLeague, sportType: .football)
        sut.viewDidLoad()
        XCTAssertEqual(sut.numberOfFavorites, 1)
        
        sut.didRemoveFavorite(at: 0)
        
        XCTAssertEqual(sut.numberOfFavorites, 0)
        XCTAssertFalse(mockLocal.isFavorite(leagueKey: 20))
    }
    
    
    func testDidSelectFavorite_NavigatesToDetailsWithCorrectData() {
        let dummyLeague = League(leagueKey: 30, leagueName: "Serie A", leagueLogo: nil, countryName: "Italy")
        mockLocal.saveFavorite(league: dummyLeague, sportType: .football)
        sut.viewDidLoad()
        
        sut.didSelectFavorite(at: 0)
        
        XCTAssertEqual(mockView.navigatedSport, .football)
        XCTAssertEqual(mockView.navigatedLeagueName, "Serie A")
        XCTAssertEqual(mockView.navigatedLeagueId, 30)
    }
}
