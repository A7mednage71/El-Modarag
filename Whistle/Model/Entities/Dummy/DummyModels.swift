//
//  DummyModels.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//


import Foundation

struct DummyLeaguesDetailsResponse: Codable {
    let upcomingMatches: [DummyUpcomingMatch]?
    let latestResults: [DummyLatestResult]?
    let participatingTeams: [DummyTeam]?
}

struct DummyUpcomingMatch: Codable {
    let matchId: Int
    let tournamentName: String
    let matchStatus: String
    let isLive: Bool
    let matchDate: String
    let matchTime: String
    let homeTeam: DummyTeam
    let awayTeam: DummyTeam
}

struct DummyLatestResult: Codable {
    let matchId: Int
    let matchFullDate: String
    let homeTeam: DummyTeam
    let awayTeam: DummyTeam
    
    let homeTeamScore: String
    let awayTeamScore: String
}

struct DummyTeam: Codable {
    let id: Int
    let name: String
    let logoUrl: String
}
