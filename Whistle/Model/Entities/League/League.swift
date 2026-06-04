//
//  League.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//

import Foundation


struct LeagueResponse: Codable {
    let result: [LeagueDtO]
}

struct LeagueDtO: Codable {
    let leagueKey: Int?
    let leagueName: String?
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
    
    func toLeague() -> League {
        return League(
            leagueKey: leagueKey,
            leagueName: leagueName,
            leagueLogo: leagueLogo,
            countryName: countryName
        )
    }
}


struct League : Codable{
    let leagueKey: Int?
    let leagueName: String?
    let leagueLogo: String?
    let countryName: String?
}


struct FavoriteLeague : Codable{
    let leagueKey: Int?
    let leagueName: String?
    let leagueLogo: String?
    let countryName: String?
    let sportType: String
}
