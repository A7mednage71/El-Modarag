//
//  LeaguesDetailsPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//

import Foundation

protocol LeaguesDetailsPresenterProtocol: AnyObject {
    var getSelectedSport: Sport{get}
    func viewDidLoad()
    func numberOfItems(in section: Section) -> Int
    func upcomingMatch(at index: Int) -> LeagueFixture
    func latestResult(at index: Int) -> LeagueFixture
    func team(at index: Int) -> Team
    func didSelectTeam(at index: Int)
}

class LeaguesDetailsPresenter : LeaguesDetailsPresenterProtocol{
    
    private let networkService: NetworkServicesProtocol
   
    private weak var view:LeaguesDetailsViewProtocol?
    private let selectedSport: Sport
    private let leagueId: Int
    
    var getSelectedSport: Sport{
        return selectedSport
    }
    
    
    let group = DispatchGroup()
    var errorMessage: String? = nil
    
    private var upcomingMatches: [LeagueFixture] = []
    private var latestResults: [LeagueFixture] = []
    private var participatingTeams: [Team] = []
    private var tennisPlayers: [TennisPlayer] = []
    
    init(view: LeaguesDetailsViewProtocol , selectedSport: Sport , leagueId: Int ,
         networkService: NetworkServicesProtocol) {
        self.view = view
        self.selectedSport = selectedSport
        self.leagueId = leagueId
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        fetchLeagueDetailsData()
    }
    
    //DispatchGroup -> A tool specifically designed in iOS to monitor multiple
    // requests running simultaneously, and as soon as they all finish
    // (whether they succeed or fail), it locks the Loader and refreshes
    // the screen with one tap.
    
    func fetchLeagueDetailsData(){
        errorMessage = nil
        view?.showLoading()
        
        group.enter()
        fetchUpcomingMatches()
        
        group.enter()
        fetchLatestResults()
        
        if selectedSport != .tennis {
            group.enter()
            fetchLeagueTeams()
        }
    
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            if self.selectedSport == .tennis {
                self.extractTennisPlayersLocally()
            }
            
            self.view?.hideLoading()
            if let errorMsg = errorMessage {
                self.view?.showError(message: errorMsg)
            } else {
                self.view?.refreshCollectionView()
            }
        }
    }
    
    private func fetchUpcomingMatches() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let today = Date()
        let month = Calendar.current.date(byAdding: .year, value: 4, to: today) ?? today
        
        let upcomingRequest = LeagueFixturesRequest(
                sport: selectedSport,
                leagueId: leagueId,
                fromDate: formatter.string(from: today),
                toDate: formatter.string(from: month),
                timeZone: "Africa/Cairo"
            )
                
        networkService.getLeagueFixturesData(request: upcomingRequest) { [weak self] result in
            guard let self = self else { return }
            
            defer { group.leave() }
            
            switch result {
                case .success(let response):
                    self.upcomingMatches = response.result ?? []
                case .failure(let error):
                   self.errorMessage = error.localizedDescription
            }
        }
    }
        
    private func fetchLatestResults() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")

            
        let today = Date()
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) ?? today

        let latestRequest = LeagueFixturesRequest(
                    sport: selectedSport,
                    leagueId: leagueId,
                    fromDate: formatter.string(from: sixMonthsAgo),
                    toDate: formatter.string(from: today),
                    timeZone: "Africa/Cairo"
                )
        
        networkService.getLeagueFixturesData(request: latestRequest) { [weak self] result in
            guard let self = self else { return }
            
            defer { group.leave() }

            switch result {
                case .success(let response):
                    self.latestResults = response.result ?? []
                case .failure(let error):
                   self.errorMessage = error.localizedDescription
                }
            }
    }
    
    private func fetchLeagueTeams() {
        networkService.getLeagueTeams(leagueId: leagueId, sport: selectedSport){ [weak self] result in
            guard let self = self else { return }
            
            defer { group.leave() }

            switch result {
                case .success(let response):
                   self.participatingTeams = response.result ?? []
                case .failure(let error):
                   self.errorMessage = error.localizedDescription
                }
            }
    }
    
    private func extractTennisPlayersLocally() {
        var uniquePlayers = Set<TennisPlayer>()
        let allMatches = latestResults + upcomingMatches
        
        for match in allMatches {
            let playersInMatch = [
                (name: match.eventHomeTeam, logo: match.homeTeamLogo),
                (name: match.eventAwayTeam, logo: match.awayTeamLogo)
            ]
            
            for player in playersInMatch {
                if let name = player.name, !name.isEmpty {
                    let pId = name.hashValue
                    uniquePlayers.insert(TennisPlayer(id: pId, name: name, logo: player.logo))
                }
            }
        }
        
        self.tennisPlayers = uniquePlayers.sorted { $0.name < $1.name }
        self.participatingTeams = self.tennisPlayers.map { player in
            return Team(teamKey: player.id, teamName: player.name, teamLogo: player.logo, players: [])
        }
    }
    
    func numberOfItems(in section: Section) -> Int {
        switch section {
        case .upcomingEvents: return upcomingMatches.count
        case .latestResults: return latestResults.count
        case .teamsList: return participatingTeams.count
        }
    }
    
    func upcomingMatch(at index: Int) -> LeagueFixture {
        return upcomingMatches[index]
    }
    
    func latestResult(at index: Int) -> LeagueFixture {
        return latestResults[index]
    }
    
    func team(at index: Int) -> Team {
        return participatingTeams[index]
    }
    
    func didSelectTeam(at index: Int) {
        let team = team(at: index)
        self.view?.navigateToTeamDetailsScreen(with: team , selectedSport: selectedSport)
    }
    
}
