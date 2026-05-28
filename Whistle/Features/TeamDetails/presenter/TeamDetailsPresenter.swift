//
//  TeamDetailsPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//

import Foundation


protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    var numberOfPlayers: Int { get }
    func team(at index: Int) -> Team?
    func player(at index: Int) -> Player?

}

class TeamDetailsPresenter  : TeamDetailsPresenterProtocol{
    
    weak var view: TeamDetailsViewProtocol?
    
    init(view: TeamDetailsViewProtocol) {
        self.view = view
    }
    
    private var teamData : Team?
    
    var numberOfPlayers: Int{
        return teamData?.players?.count ?? 20
    }
    
    
    func viewDidLoad() {
        fetchTeamData()
    }
    
    private func fetchTeamData(){
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){ [weak self] in
            self?.view?.reloadPlayersList()
            
           // self?.view?.showEmptyState(message: "No players available in this team squad.")
            self?.view?.hideLoading()
        }
    }
    
    func team(at index: Int) -> Team? {
        return teamData
    }
    
    func player(at index: Int) -> Player? {
        guard let players = teamData?.players, index >= 0
                && index < players.count else { return nil }
        return players[index]
    }
}
