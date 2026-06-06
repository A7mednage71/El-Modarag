//
//  NetworkServices.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServicesProtocol {
    func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void)
    
    func getLeagueFixturesData(request: LeagueFixturesRequest, completion: @escaping (Result<LeagueFixturesResponse, AFError>) -> Void)
    
    func getLeagueTeams(leagueId: Int, sport: Sport, completion: @escaping (Result<TeamResponse, AFError>) -> Void)
        
    func getPlayersData(teamId: Int, sport: Sport, completion: @escaping (Result<PlayerResponse, AFError>) -> Void)
}

class NetworkServices: NetworkServicesProtocol {
    
    private let client: NetworkClientProtocol
        
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    
    func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void) {
        client.fetchData(target: SportApiConfig.leagues(sport: sport), responseType: LeagueResponse.self, completion: completion)
    }
    
    func getLeagueFixturesData(request: LeagueFixturesRequest, completion: @escaping (Result<LeagueFixturesResponse, AFError>) -> Void) {
        
        switch request.sport {
           case .football:
                client.fetchData(target: SportApiConfig.LeagueFixtures(request: request), responseType: LeagueFixturesResponse.self) { completion($0) }
            
           case .basketball:
                 client.fetchData(target: SportApiConfig.LeagueFixtures(request: request), responseType: BasketballFixturesResponse.self) { result in
                   completion(result.map { $0.toLeagueFixturesResponse() })
                  }
            
           case .tennis:
                client.fetchData(target: SportApiConfig.LeagueFixtures(request: request), responseType: TennisFixturesResponse.self) { result in
                   completion(result.map { $0.toLeagueFixturesResponse() })
                 }
            
           case .cricket:
                client.fetchData(target: SportApiConfig.LeagueFixtures(request: request), responseType: CricketFixturesResponse.self) { result in
                   completion(result.map { $0.toLeagueFixturesResponse() })
                }
        }
    }
    
    func getLeagueTeams(leagueId: Int, sport: Sport, completion: @escaping (Result<TeamResponse, AFError>) -> Void) {
        client.fetchData(target: SportApiConfig.LeagueTeams(leagueId: leagueId, sport: sport), responseType: TeamResponse.self, completion: completion)
    }
        
    func getPlayersData(teamId: Int, sport: Sport, completion: @escaping (Result<PlayerResponse, AFError>) -> Void) {
        client.fetchData(target: SportApiConfig.players(teamId: teamId, sport: sport), responseType: PlayerResponse.self, completion: completion)
    }
}
