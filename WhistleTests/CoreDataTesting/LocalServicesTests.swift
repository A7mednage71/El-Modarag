//
//  LocalServicesTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
import XCTest
import Alamofire
@testable import Whistle


class LocalServicesTests: XCTestCase {
    
    var sut: LocalServices!
    var mockDatabase: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        mockDatabase = MockCoreDataManager()
        sut = LocalServices(databaseManager: mockDatabase)
    }
    
    override func tearDown() {
        sut = nil
        mockDatabase = nil
        super.tearDown()
    }
    
    func testSaveFavorite_CallsDatabase() {
        let league = League(leagueKey: 11, leagueName: "Serie A", leagueLogo: nil, countryName: "Italy")
        
        sut.saveFavorite(league: league, sportType: .football)
        
        XCTAssertTrue(mockDatabase.isSaveCalled)
        XCTAssertTrue(sut.isFavorite(leagueKey: 11))
    }
    
    func testFetchAllFavorites_ReturnsCorrectData() {
        let league = League(leagueKey: 22, leagueName: "Bundesliga", leagueLogo: nil, countryName: "Germany")
        sut.saveFavorite(league: league, sportType: .football)
        
        let favorites = sut.fetchAllFavorites()
        
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.leagueName, "Bundesliga")
    }
    
    func testDeleteFavorite_RemovesLeague() {
        let league = League(leagueKey: 33, leagueName: "Ligue 1", leagueLogo: nil, countryName: "France")
        sut.saveFavorite(league: league, sportType: .football)
        
        sut.deleteFavorite(leagueKey: 33)
        
        XCTAssertTrue(mockDatabase.isDeleteCalled)
        XCTAssertFalse(sut.isFavorite(leagueKey: 33))
    }
}
