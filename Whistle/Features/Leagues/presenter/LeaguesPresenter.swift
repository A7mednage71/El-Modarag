//
//  LeaguesPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 29/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    var numberOfLeagues: Int { get }
    func viewDidLoad()
    func league(at index: Int) -> League
    func didSelectLeague(at index: Int)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private let selectedSport: Sport
    private var leaguesList: [League] = []
    
    init(view: LeaguesViewProtocol, selectedSport: Sport) {
        self.view = view
        self.selectedSport = selectedSport
    }
    
    var numberOfLeagues: Int {
        return leaguesList.count
    }
    
    func viewDidLoad() {
        fetchLeagues()
    }
    
    private func fetchLeagues() {
        view?.showLoading()
        
        NetworkServices.getLeagueData(sport: selectedSport){ [weak self] result in
            
            self?.view?.hideLoading()
            
            switch result{
              case .success(let response):
                self?.leaguesList = response.result
                self?.view?.reloadLeaguesData()
              case .failure(let error) :
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func league(at index: Int) -> League {
        return leaguesList[index]
    }
    
    func didSelectLeague(at index: Int) {
        let selected = leaguesList[index]
        print("User clicked on league: \(selected.leagueName)")
    }
}
