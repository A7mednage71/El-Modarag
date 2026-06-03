//
//  LeaguesDetailsPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//

import Foundation

protocol LeaguesDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems(in section: Section) -> Int
    func upcomingMatch(at index: Int) -> LeagueFixture
    func latestResult(at index: Int) -> LeagueFixture
    func team(at index: Int) -> Team
}

class LeaguesDetailsPresenter : LeaguesDetailsPresenterProtocol{
    
    private weak var view:LeaguesDetailsViewProtocol?
    private let selectedSport: Sport
    private let leagueId: Int
    
    let group = DispatchGroup()
    var errorMessage: String? = nil
    
    private var upcomingMatches: [LeagueFixture] = []
    private var latestResults: [LeagueFixture] = []
    private var participatingTeams: [Team] = []
    
    init(view: LeaguesDetailsViewProtocol , selectedSport: Sport , leagueId: Int) {
        self.view = view
        self.selectedSport = selectedSport
        self.leagueId = leagueId
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
        
        group.enter()
        fetchLeagueTeams()
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
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
        
        let today = Date()
        let month = Calendar.current.date(byAdding: .month, value: 1, to: today) ?? today
        
        let upcomingRequest = LeagueFixturesRequest(
                sport: selectedSport,
                leagueId: leagueId,
                fromDate: formatter.string(from: today),
                toDate: formatter.string(from: month),
                timeZone: "Africa/Cairo"
            )
                
        NetworkServices.getLeagueFixturesData(request: upcomingRequest) { [weak self] result in
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
            
        let today = Date()
        let month = Calendar.current.date(byAdding: .month, value: -1, to: today) ?? today

        let latestRequest = LeagueFixturesRequest(
                    sport: selectedSport,
                    leagueId: leagueId,
                    fromDate: formatter.string(from: month),
                    toDate: formatter.string(from: today),
                    timeZone: "Africa/Cairo"
                )
        
        NetworkServices.getLeagueFixturesData(request: latestRequest) { [weak self] result in
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
        NetworkServices.getLeagueTeams(leagueId: leagueId, sport: selectedSport){ [weak self] result in
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
    
}
