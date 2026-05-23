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
    func upcomingMatch(at index: Int) -> DummyUpcomingMatch
    func latestResult(at index: Int) -> DummyLatestResult
    func team(at index: Int) -> DummyTeam
}

class LeaguesDetailsPresenter : LeaguesDetailsPresenterProtocol{
    
    private weak var view:LeaguesDetailsViewProtocol?
    
    private var upcomingMatches: [DummyUpcomingMatch] = []
    private var latestResults: [DummyLatestResult] = []
    private var participatingTeams: [DummyTeam] = []
    
    init(view: LeaguesDetailsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchDummyScreenData()
    }
    
    func fetchDummyScreenData(){
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){ [weak self] in
            self?.view?.refreshCollectionView()
            self?.view?.hideLoading()
        }
    }
    
    func numberOfItems(in section: Section) -> Int {
        switch section {
            case .upcomingEvents: return 5
            case .latestResults: return 5
            case .teamsList: return 5
        }
    }
    
    func upcomingMatch(at index: Int) -> DummyUpcomingMatch {
        return upcomingMatches[index]
    }
    
    func latestResult(at index: Int) -> DummyLatestResult {
        return latestResults[index]
    }
    
    func team(at index: Int) -> DummyTeam {
        return participatingTeams[index]
    }
    
}
