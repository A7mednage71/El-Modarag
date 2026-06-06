//
//  TeamDetailsPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//

import Foundation


protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    var  numberOfPlayers: Int { get }
    var  getTeamData : Team{ get }
    func player(at index: Int) -> Player?
}

class TeamDetailsPresenter  : TeamDetailsPresenterProtocol{
    
    private let networkService: NetworkServicesProtocol

    
    weak var view: TeamDetailsViewProtocol?
    private var players:[Player] = []

    private var teamData : Team
    private let selectedSport: Sport
    
    var getTeamData: Team{
        return teamData
    }
    
    var numberOfPlayers: Int{
        return players.count
    }
    
    
    init(view: TeamDetailsViewProtocol , teamData : Team , selectedSport: Sport , networkService: NetworkServicesProtocol
     ) {
        self.view = view
        self.teamData = teamData
        self.selectedSport = selectedSport
        self.networkService = networkService
    }
        
    func viewDidLoad() {
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            networkService.getPlayersData(teamId: self.teamData.teamKey!, sport: self.selectedSport) { result in
                
                self.view?.hideLoading()
                
                switch result {
                case .success(let response):
                    self.players = response.result ?? []
                    self.view?.reloadPlayersList()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    func player(at index: Int) -> Player? {
        return players[index]
    }
}
