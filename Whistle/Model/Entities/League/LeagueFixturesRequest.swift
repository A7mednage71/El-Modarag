//
//  LeagueFixturesRequest.swift
//  Whistle
//
//  Created by Ahmed Nageh on 02/06/2026.
//

import Foundation


struct LeagueFixturesRequest {
    let sport: Sport
    let leagueId: Int
    let fromDate: String
    let toDate: String
    let timeZone: String
    
    var leagueIdString: String {
        return String(leagueId)
    }
}
