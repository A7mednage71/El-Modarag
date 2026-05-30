//
//  LeaguesPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 29/05/2026.
//

import Foundation

struct League {
    let name: String
    let logoName: String
    let country: String
}

protocol LeaguesPresenterProtocol: AnyObject {
    var numberOfLeagues: Int { get }
    func viewDidLoad()
    func league(at index: Int) -> League
    func didSelectLeague(at index: Int)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private var leaguesList: [League] = []
    
    init(view: LeaguesViewProtocol) {
        self.view = view
    }
    
    var numberOfLeagues: Int {
        return leaguesList.count
    }
    
    func viewDidLoad() {
        fetchLeagues()
    }
    
    private func fetchLeagues() {
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.leaguesList = [
                League(name: "Premier League", logoName: "premier_league", country: "England"),
                League(name: "NBA", logoName: "nba_img", country: "USA"),
                League(name: "La Liga", logoName: "la_liga", country: "Spain"),
                League(name: "Bundesliga", logoName: "bundesliga", country: "Germany"),
                League(name: "Serie A", logoName: "serie_a", country: "Italy"),
                League(name: "Ligue 1", logoName: "ligue_1", country: "France")
            ]
            
            self.view?.hideLoading()
            self.view?.reloadLeaguesData()
        }
    }
    
    func league(at index: Int) -> League {
        return leaguesList[index]
    }
    
    func didSelectLeague(at index: Int) {
        let selected = leaguesList[index]
        print("User clicked on league: \(selected.name)")
    }
}
