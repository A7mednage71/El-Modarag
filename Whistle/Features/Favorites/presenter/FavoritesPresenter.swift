//
//  FavoritesPresenter.swift
//  Whistle
//
//  Created by Omar on 31/05/2026.
//


import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    var numberOfFavorites: Int { get }
    func viewDidLoad()
    func favoriteItem(at index: Int) -> FavoriteLeague
    func didSelectFavorite(at index: Int)
    func didRemoveFavorite(at index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    private let localService: LocalServicesProtocol

    private weak var view: FavoritesViewProtocol?
    private var favoritesList: [FavoriteLeague] = []
    
    var numberOfFavorites: Int {
        return favoritesList.count
    }
    
    init(view: FavoritesViewProtocol , localService: LocalServicesProtocol) {
        self.view = view
        self.localService = localService
    }
    
    func viewDidLoad() {
        loadFavoritesLeagues()
    }
    
    private func loadFavoritesLeagues() {
        view?.showLoading()
        
        favoritesList = localService.fetchAllFavorites()
        
        self.view?.hideLoading()
        self.view?.reloadFavoritesData()
    }
    
    func favoriteItem(at index: Int) -> FavoriteLeague {
        return favoritesList[index]
    }
    
    func didRemoveFavorite(at index: Int) {
        let targetLeague = favoritesList[index]
        localService.deleteFavorite(leagueKey: targetLeague.leagueKey ?? 0)
        favoritesList.remove(at: index)
    }
    
    func didSelectFavorite(at index: Int) {
        let league = favoritesList[index]
        let sportType = Sport(rawValue: league.sportType)
        self.view?.navigateToLeagueDetailsScreen(sport: sportType, leagueName: league.leagueName ?? "", leagueId: league.leagueKey)
    }
}
