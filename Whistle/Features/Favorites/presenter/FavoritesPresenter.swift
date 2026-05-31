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
        return 20
       // return favoritesList.count
    }
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        loadMockFavorites()
    }
    
    private func loadMockFavorites() {
        view?.showLoading()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.view?.hideLoading()
            self?.view?.reloadFavoritesData()
        }
    }
    
    func favoriteItem(at index: Int) -> League {
        return favoritesList[index]
    }
    
    func didRemoveFavorite(at index: Int) {
        
    }
    
    func didSelectFavorite(at index: Int) {
    }
}
