



import XCTest
import Alamofire
@testable import Whistle

class NetworkServicesTests: XCTestCase {
    
    var sut: NetworkServices!
    var mockClient: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockNetworkClient()
        sut = NetworkServices(client: mockClient)
    }
    
    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    func testGetLeagueData_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Should fetch league data successfully")
            
        sut.getLeagueData(sport: .football) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetLeagueFixturesData_Football_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        
        let request = LeagueFixturesRequest(
            sport: .football,
            leagueId: 10,
            fromDate: "2026-06-01",
            toDate: "2026-06-06",
            timeZone: "Africa/Cairo"
        )
        
        let expectation = self.expectation(description: "Should fetch football fixtures successfully")
        
        sut.getLeagueFixturesData(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetLeagueFixturesData_Basketball_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        let request = LeagueFixturesRequest(
            sport: .basketball,
            leagueId: 10,
            fromDate: "2026-06-01",
            toDate: "2026-06-06",
            timeZone: "Africa/Cairo"
        )
        
        let expectation = self.expectation(description: "Should fetch basketball fixtures and map correctly")
        
        sut.getLeagueFixturesData(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetLeagueFixturesData_Tennis_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        
        let request = LeagueFixturesRequest(
            sport: .tennis,
            leagueId: 10,
            fromDate: "2026-06-01",
            toDate: "2026-06-06",
            timeZone: "Africa/Cairo"
        )
        let expectation = self.expectation(description: "Should fetch tennis fixtures and map correctly")
        
        sut.getLeagueFixturesData(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetLeagueFixturesData_Cricket_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        
        let request = LeagueFixturesRequest(
            sport: .cricket,
            leagueId: 10,
            fromDate: "2026-06-01",
            toDate: "2026-06-06",
            timeZone: "Africa/Cairo"
        )
        let expectation = self.expectation(description: "Should fetch cricket fixtures and map correctly")
        
        sut.getLeagueFixturesData(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    

    func testGetLeagueTeams_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Should fetch league teams successfully")
        
        sut.getLeagueTeams(leagueId: 10, sport: .football) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetPlayersData_Success() {
        let jsonString = "{\"success\": 1, \"result\": []}"
        mockClient.mockData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Should fetch players data successfully")
        
        sut.getPlayersData(teamId: 5, sport: .football) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    

    func testGetLeagueData_Failure_NetworkError() {
        mockClient.shouldReturnError = true
        let expectation = self.expectation(description: "Should return network error on failure")
        
        sut.getLeagueData(sport: .football) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
    
}
