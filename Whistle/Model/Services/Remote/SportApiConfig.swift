//
//  SportApiConfig.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation
import Alamofire

struct SportApiConfig : URLRequestConvertible{
    
    let path: String
    let parameters: [String: String]
    let method: HTTPMethod
    
    private static let domainURL = "https://apiv2.allsportsapi.com/"
    
    var baseURL: URL {
        let fullURLString = SportApiConfig.domainURL + path
        guard let url = URL(string: fullURLString) else {
            fatalError("❌ Invalid URL Construction: \(fullURLString)")
        }
        return url
    }
        
    
    static func leagues(sport: Sport) -> SportApiConfig {
        return SportApiConfig(
            path: sport.pathValue,
            parameters: ["met": "Leagues"],
            method: .get
        )
    }
    
    static func LeagueFixtures(request:LeagueFixturesRequest) -> SportApiConfig {
        return SportApiConfig(
            path: request.sport.pathValue,
            parameters: [
                "met": "Fixtures",
                "from": request.fromDate,
                "to": request.toDate,
                "leagueId": request.leagueIdString,
                "timezone": request.timeZone
            ],
            method: .get
        )
    }
    
    static func LeagueTeams(leagueId: Int, sport: Sport) -> SportApiConfig {
        return SportApiConfig(
            path: sport.pathValue,
            parameters: [
                "met": "Teams",
                "leagueId": String(leagueId)
            ],
            method: .get
        )
    }
        
    static func players(teamId: Int, sport: Sport) -> SportApiConfig {
        return SportApiConfig(
            path: sport.pathValue,
            parameters: [
                "met": "Players",
                "teamId": String(teamId)
            ],
            method: .get
        )
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 15
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
        
        // It takes your Swift dictionary parameters (e.g., ["met": "Leagues"])
        // and flattens them into a standard URL-safe string format (e.g., "met=Leagues").
        // automatically appends that serialized string to the end of your baseURL
    }
    
}

// URLRequestConvertible :-

// protocol built into the Alamofire library. His only job in life is to
// force any class or Struct inherited from it to implement a function called: "asURLRequest"
// in order to transform itself into a ready URLRequest.
