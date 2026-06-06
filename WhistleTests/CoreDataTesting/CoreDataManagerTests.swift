//
//  CoreDataManagerTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//
import XCTest
import CoreData
@testable import Whistle

class CoreDataManagerTests: XCTestCase {
    
    var sut: CoreDataManager!
    var mockPersistentContainer: NSPersistentContainer!
    
    override func setUp() {
        super.setUp()
        
        mockPersistentContainer = NSPersistentContainer(name: "Whistle")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        mockPersistentContainer.persistentStoreDescriptions = [description]
        
        mockPersistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error, "Failed to load in-memory store")
        }
        
        sut = CoreDataManager(testingContext: mockPersistentContainer.viewContext)
    }
    
    override func tearDown() {
        sut = nil
        mockPersistentContainer = nil
        super.tearDown()
    }

    func testSaveFavoriteLeague_Success() {
        // Given
        let league = League(leagueKey: 44, leagueName: "EPL", leagueLogo: nil, countryName: "England")
        
        // When
        sut.saveFavoriteLeague(league: league, sportType: .football)
        
        // Then
        let results = sut.fetchAllFavorites()
        
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.leagueName, "EPL")
        XCTAssertEqual(results.first?.leagueKey, 44)
    }
    
    func testDeleteFavoriteLeague() {
        // Given
        let league = League(leagueKey: 55, leagueName: "La Liga", leagueLogo: nil, countryName: "Spain")
        
        sut.saveFavoriteLeague(league: league, sportType: .football)
        
        XCTAssertTrue(sut.isLeagueFavorite(leagueKey: 55))

        sut.deleteFavoriteLeague(leagueKey: 55)
        
        // Then
        XCTAssertFalse(sut.isLeagueFavorite(leagueKey: 55))
        XCTAssertEqual(sut.fetchAllFavorites().count, 0)
    }
}
