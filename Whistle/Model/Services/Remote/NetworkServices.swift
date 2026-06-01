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
}

class NetworkServices: NetworkServicesProtocol {
    
    private init() {}
    
    static func getLeagueData(sport: Sport, completion: @escaping (Result<LeagueResponse, AFError>) -> Void) {
        NetworkClient.fetchData(target: SportApiConfig.leagues(sport: sport), responseType: LeagueResponse.self, completion: completion)
    }
    
}
