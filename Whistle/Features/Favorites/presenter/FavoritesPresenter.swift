//
//  FavoritesPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//


import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    var numberOfFavorites: Int { get }
    func viewDidLoad()
    func favoriteItem(at index: Int) -> League
    func didSelectFavorite(at index: Int)
    func didRemoveFavorite(at index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {

    private weak var view: FavoritesViewProtocol?
    private var favoritesList: [League] = []
    
    var numberOfFavorites: Int {
        return favoritesList.count
    }
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        loadFavoritesLeagues()
    }
    
    private func loadFavoritesLeagues() {
        view?.showLoading()
        
        favoritesList = LocalServices.fetchAllFavorites()
        
        self.view?.hideLoading()
        self.view?.reloadFavoritesData()
    }
    
    func favoriteItem(at index: Int) -> League {
        return favoritesList[index]
    }
    
    func didRemoveFavorite(at index: Int) {
        let targetLeague = favoritesList[index]
        LocalServices.deleteFavorite(leagueKey: targetLeague.leagueKey ?? 0)
        favoritesList.remove(at: index)
    }
    
    func didSelectFavorite(at index: Int) {
    }
}
