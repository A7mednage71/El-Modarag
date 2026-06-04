//
//  LeagueFixturesResponse.swift
//  Whistle
//
//  Created by Ahmed Nageh on 02/06/2026.
//

import Foundation

// MARK: - Football Models (Default Model for UI & Presenter)
struct LeagueFixturesResponse: Codable {
    let result: [LeagueFixture]?
}

struct LeagueFixture: Codable {
    let eventDate:        String?
    let eventTime:        String?
    let eventHomeTeam:    String?
    let eventAwayTeam:    String?
    let eventFinalResult: String?
    let eventStatus:      String?
    let homeTeamLogo:     String?
    let awayTeamLogo:     String?
    let leagueName:       String?

    enum CodingKeys: String, CodingKey {
        case eventDate        = "event_date"
        case eventTime        = "event_time"
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case homeTeamLogo     = "home_team_logo"
        case awayTeamLogo     = "away_team_logo"
        case leagueName       = "league_name"
    }
}


// MARK: - Basketball Models & Mapping
struct BasketballFixturesResponse: Decodable {
    let result: [BasketballEventResponse]?
    
    func toLeagueFixturesResponse() -> LeagueFixturesResponse {
        let mappedList = (result ?? []).map { $0.toLeagueFixture() }
        return LeagueFixturesResponse(result: mappedList)
    }
}

struct BasketballEventResponse: Decodable {
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?
    
    enum CodingKeys: String, CodingKey {
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "event_home_team_logo"
        case awayTeamLogo     = "event_away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case eventDate        = "event_date"
        case eventTime        = "event_time"
    }
    
    func toLeagueFixture() -> LeagueFixture {
        return LeagueFixture(
            eventDate: self.eventDate,
            eventTime: self.eventTime,
            eventHomeTeam: self.eventHomeTeam,
            eventAwayTeam: self.eventAwayTeam,
            eventFinalResult: self.eventFinalResult,
            eventStatus: self.eventStatus,
            homeTeamLogo: self.homeTeamLogo,
            awayTeamLogo: self.awayTeamLogo,
            leagueName: nil
        )
    }
}


// MARK: - Tennis Models & Mapping
struct TennisFixturesResponse: Decodable {
    let result: [TennisEventResponse]?
    
    func toLeagueFixturesResponse() -> LeagueFixturesResponse {
        let mappedList = (result ?? []).map { $0.toLeagueFixture() }
        return LeagueFixturesResponse(result: mappedList)
    }
}

struct TennisEventResponse: Decodable {
    let firstPlayer: String?
    let secondPlayer: String?
    let firstPlayerLogo: String?
    let secondPlayerLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?
    
    enum CodingKeys: String, CodingKey {
        case firstPlayer       = "event_first_player"
        case secondPlayer      = "event_second_player"
        case firstPlayerLogo   = "event_first_player_logo"
        case secondPlayerLogo  = "event_second_player_logo"
        case eventFinalResult  = "event_final_result"
        case eventStatus       = "event_status"
        case eventDate         = "event_date"
        case eventTime         = "event_time"
    }
    
    func toLeagueFixture() -> LeagueFixture {
        return LeagueFixture(
            eventDate: self.eventDate,
            eventTime: self.eventTime,
            eventHomeTeam: self.firstPlayer,
            eventAwayTeam: self.secondPlayer,
            eventFinalResult: self.eventFinalResult,
            eventStatus: self.eventStatus,
            homeTeamLogo: self.firstPlayerLogo,
            awayTeamLogo: self.secondPlayerLogo,
            leagueName: nil
        )
    }
}


// MARK: - Cricket Models & Mapping
struct CricketFixturesResponse: Decodable {
    let result: [CricketEventResponse]?
    
    func toLeagueFixturesResponse() -> LeagueFixturesResponse {
        let mappedList = (result ?? []).map { $0.toLeagueFixture() }
        return LeagueFixturesResponse(result: mappedList)
    }
}

struct CricketEventResponse: Decodable {
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let homeFinalResult: String?
    let awayFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?
    
    enum CodingKeys: String, CodingKey {
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "event_home_team_logo"
        case awayTeamLogo     = "event_away_team_logo"
        case homeFinalResult  = "event_home_final_result"
        case awayFinalResult  = "event_away_final_result"
        case eventStatus      = "event_status"
        case eventDate        = "event_date_start"
        case eventTime        = "event_time"
    }
    
    func toLeagueFixture() -> LeagueFixture {
        let combinedResult = "\(self.homeFinalResult ?? "-") : \(self.awayFinalResult ?? "-")"
        
        return LeagueFixture(
            eventDate: self.eventDate,
            eventTime: self.eventTime,
            eventHomeTeam: self.eventHomeTeam,
            eventAwayTeam: self.eventAwayTeam,
            eventFinalResult: combinedResult,
            eventStatus: self.eventStatus,
            homeTeamLogo: self.homeTeamLogo,
            awayTeamLogo: self.awayTeamLogo,
            leagueName: nil
        )
    }
}
