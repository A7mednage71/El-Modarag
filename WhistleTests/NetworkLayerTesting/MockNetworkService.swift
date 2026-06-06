//
//  MockNetworkService.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
import Alamofire
@testable import Whistle

class MockNetworkService: NetworkServicesProtocol {
    
    var shouldReturnError = false
    
    var mockLeagueResponse: LeagueResponse?
    var mockFixturesResponse: LeagueFixturesResponse?
    var mockTeamResponse: TeamResponse?
    var mockPlayerResponse: PlayerResponse?
    
    func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void) {
        if shouldReturnError {
            let error = AFError.sessionTaskFailed(error: URLError(.badServerResponse))
            completion(.failure(error))
        } else if let response = mockLeagueResponse {
            completion(.success(response))
        }
    }
    
    func getLeagueFixturesData(request: LeagueFixturesRequest, completion: @escaping (Result<LeagueFixturesResponse, AFError>) -> Void) {
        if shouldReturnError {
            let error = AFError.sessionTaskFailed(error: URLError(.badServerResponse))
            completion(.failure(error))
        } else if let response = mockFixturesResponse {
            completion(.success(response))
        }
    }
    
    func getLeagueTeams(leagueId: Int, sport: Sport, completion: @escaping (Result<TeamResponse, AFError>) -> Void) {
        if shouldReturnError {
            let error = AFError.sessionTaskFailed(error: URLError(.badServerResponse))
            completion(.failure(error))
        } else if let response = mockTeamResponse {
            completion(.success(response))
        }
    }
    
    func getPlayersData(teamId: Int, sport: Sport, completion: @escaping (Result<PlayerResponse, AFError>) -> Void) {
        if shouldReturnError {
            let error = AFError.sessionTaskFailed(error: URLError(.badServerResponse))
            completion(.failure(error))
        } else if let response = mockPlayerResponse {
            completion(.success(response))
        }
    }
}
