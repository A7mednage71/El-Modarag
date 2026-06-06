//
//  LeaguesPresenter.swift
//  Whistle
//
//  Created by Omar on 29/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    var  numberOfLeagues: Int { get }
    var  getSelectedSport : Sport {get}
    func viewDidLoad()
    func league(at index: Int) -> League
    func didSelectLeague(at index: Int)
    func isLeagueFavorite(at index: Int) -> Bool
    func toggleFavorite(at index: Int)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    private let networkService: NetworkServicesProtocol
    private let localService: LocalServicesProtocol

    
    weak var view: LeaguesViewProtocol?
    private let selectedSport: Sport
    private var leaguesList: [League] = []
    
    init(view: LeaguesViewProtocol, selectedSport: Sport , networkService: NetworkServicesProtocol,localService: LocalServicesProtocol) {
        self.view = view
        self.selectedSport = selectedSport
        self.networkService = networkService
        self.localService = localService
    }
    
    var numberOfLeagues: Int {
        return leaguesList.count
    }
    
    var getSelectedSport: Sport{
        return selectedSport
    }

    
    func viewDidLoad() {
        fetchLeagues()
    }
    
    private func fetchLeagues() {
        view?.showLoading()
        
        networkService.getLeagueData(sport: selectedSport){ [weak self] result in
            
            self?.view?.hideLoading()
            
            switch result{
              case .success(let response):
                self?.leaguesList = response.result.map{$0.toLeague()}
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
        view?.navigateToLeaguesScreen(sport: selectedSport,leagueName:selected.leagueName ?? "" , leagueId: selected.leagueKey)
    }
    
    func isLeagueFavorite(at index: Int) -> Bool {
        let leagueItem = leaguesList[index]
        return localService.isFavorite(leagueKey: leagueItem.leagueKey)
    }
        
    func toggleFavorite(at index: Int) {
        let leagueItem = leaguesList[index]
            
        if localService.isFavorite(leagueKey: leagueItem.leagueKey) {
            localService.deleteFavorite(leagueKey: leagueItem.leagueKey ?? 0)
        } else {
            localService.saveFavorite(league: leagueItem, sportType: selectedSport)
        }
    }
}
