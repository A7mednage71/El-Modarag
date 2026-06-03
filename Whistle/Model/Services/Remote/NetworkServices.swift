//
//  NetworkServices.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServicesProtocol {
    static func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void)
    
    static func getLeagueFixturesData(request: LeagueFixturesRequest, completion: @escaping (Result<LeagueFixturesResponse, AFError>) -> Void)
    
    static func getLeagueTeams(leagueId: Int, sport: Sport, completion: @escaping (Result<TeamResponse, AFError>) -> Void)
        
    static func getPlayersData(teamId: Int, sport: Sport, completion: @escaping (Result<PlayerResponse, AFError>) -> Void)
}

class NetworkServices: NetworkServicesProtocol {
    
    private init() {}
    
    static func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void) {
        NetworkClient.fetchData(target: SportApiConfig.leagues(sport: sport), responseType: LeagueResponse.self, completion: completion)
    }
    
    static func getLeagueFixturesData(request: LeagueFixturesRequest, completion: @escaping (Result<LeagueFixturesResponse, Alamofire.AFError>) -> Void) {
        NetworkClient.fetchData(target: SportApiConfig.LeagueFixtures(request: request), responseType: LeagueFixturesResponse.self, completion: completion)
    }
    
    static func getLeagueTeams(leagueId: Int, sport: Sport, completion: @escaping (Result<TeamResponse, AFError>) -> Void) {
            NetworkClient.fetchData(target: SportApiConfig.LeagueTeams(leagueId: leagueId, sport: sport), responseType: TeamResponse.self, completion: completion)
    }
        
    static func getPlayersData(teamId: Int, sport: Sport, completion: @escaping (Result<PlayerResponse, AFError>) -> Void) {
            NetworkClient.fetchData(target: SportApiConfig.players(teamId: teamId, sport: sport), responseType: PlayerResponse.self, completion: completion)
    }
}
