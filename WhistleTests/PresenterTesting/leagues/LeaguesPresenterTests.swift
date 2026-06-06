//
//  LeaguesPresenterTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//
import XCTest
import Alamofire
@testable import Whistle

class LeaguesPresenterTests: XCTestCase {
    
    var sut: LeaguesPresenter!
    var mockView: MockLeaguesView!
    var mockNetwork: MockNetworkService!
    var mockLocal: MockLocalService!
    
    private func makeDummyLeague(key: Int = 1, name: String = "EPL") -> League {
        return League(leagueKey: key, leagueName: name, leagueLogo: nil, countryName: "England")
    }
    
    override func setUp() {
        super.setUp()
        mockView = MockLeaguesView()
        mockNetwork = MockNetworkService()
        mockLocal = MockLocalService()
        
        sut = LeaguesPresenter(
            view: mockView,
            selectedSport: .football,
            networkService: mockNetwork,
            localService: mockLocal
        )
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockNetwork = nil
        mockLocal = nil
        super.tearDown()
    }
    
    // MARK: - 1. Test Fetch Leagues Flows
    
    func testViewDidLoad_Success_UpdatesViewAndList() {
        // Given
        let dummyItem = LeagueDtO(leagueKey: 1, leagueName: "La Liga", countryKey: nil, countryName: "Spain", leagueLogo: nil, countryLogo: nil)
        mockNetwork.mockLeagueResponse = LeagueResponse(result: [dummyItem])
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isShowLoadingCalled)
        XCTAssertTrue(mockView.isHideLoadingCalled)
        XCTAssertEqual(sut.numberOfLeagues, 1)
        XCTAssertEqual(sut.league(at: 0).leagueName, "La Liga")
        XCTAssertTrue(mockView.isReloadLeaguesDataCalled)
    }
    
    func testViewDidLoad_Failure_ShowsErrorMessage() {
        // Given
        mockNetwork.shouldReturnError = true
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isShowLoadingCalled)
        XCTAssertTrue(mockView.isHideLoadingCalled)
        XCTAssertEqual(sut.numberOfLeagues, 0)
        XCTAssertNotNil(mockView.errorMessage)
    }
    
    // MARK: - 2. Test Navigation Flow
    
    func testDidSelectLeague_NavigatesToLeaguesScreenWithCorrectData() {
        // Given
        let dummyItem = LeagueDtO(leagueKey: 7, leagueName: "Serie A", countryKey: nil, countryName: "Italy", leagueLogo: nil, countryLogo: nil)
        mockNetwork.mockLeagueResponse = LeagueResponse(result: [dummyItem])
        sut.viewDidLoad()
        
        // When
        sut.didSelectLeague(at: 0)
        
        // Then
        XCTAssertEqual(mockView.navigatedSport, .football)
        XCTAssertEqual(mockView.navigatedLeagueName, "Serie A")
        XCTAssertEqual(mockView.navigatedLeagueId, 7)
    }
    
    // MARK: - 3. Test Favorites Flow
    
    func testIsLeagueFavorite_ReturnsTrue_WhenLeagueIsSaved() {
        // Given
        let dummyItem = LeagueDtO(leagueKey: 10, leagueName: "EPL", countryKey: nil, countryName: "Egypt", leagueLogo: nil, countryLogo: nil)
        mockNetwork.mockLeagueResponse = LeagueResponse(result: [dummyItem])
        sut.viewDidLoad()
        
        mockLocal.saveFavorite(league: sut.league(at: 0), sportType: .football)
        
        // When & Then
        XCTAssertTrue(sut.isLeagueFavorite(at: 0))
    }
    
    func testToggleFavorite_SavesLeague_WhenItIsNotFavorite() {
        // Given
        let dummyItem = LeagueDtO(leagueKey: 15, leagueName: "Bundesliga", countryKey: nil, countryName: "Germany", leagueLogo: nil, countryLogo: nil)
        mockNetwork.mockLeagueResponse = LeagueResponse(result: [dummyItem])
        sut.viewDidLoad()
        
        XCTAssertFalse(sut.isLeagueFavorite(at: 0))
        
        // When
        sut.toggleFavorite(at: 0)
        
        // Then
        XCTAssertTrue(sut.isLeagueFavorite(at: 0))
    }
    
    func testToggleFavorite_DeletesLeague_WhenItIsAlreadyFavorite() {
        // Given
        let dummyItem = LeagueDtO(leagueKey: 20, leagueName: "Ligue 1", countryKey: nil, countryName: "France", leagueLogo: nil, countryLogo: nil)
        mockNetwork.mockLeagueResponse = LeagueResponse(result: [dummyItem])
        sut.viewDidLoad()
        
        sut.toggleFavorite(at: 0)
        XCTAssertTrue(sut.isLeagueFavorite(at: 0))
        
        // When
        sut.toggleFavorite(at: 0)
        
        // Then
        XCTAssertFalse(sut.isLeagueFavorite(at: 0))
    }
}
