//
//  SportsPresenter.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import Foundation

class SportsPresenter: SportsPresenterProtocol {
    
    private weak var view: SportsViewProtocol?
    private var sportsList: [Sport] = []
    
    init(view: SportsViewProtocol) {
        self.view = view
    }
    
    var numberOfSports: Int {
        return sportsList.count
    }
    
    func viewDidLoad() {
        fetchSports()
    }
    
    private func fetchSports() {
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.sportsList = [
                Sport(title: "Football", imageName: "foot_ball"),
                Sport(title: "Basketball", imageName: "Basket_ball"),
                Sport(title: "Tennis", imageName: "Tennis"),
                Sport(title: "Cricket", imageName: "Cricket")
            ]
            self.view?.hideLoading()
            self.view?.reloadSportsData()
        }
    }
    
    func sport(at index: Int) -> Sport {
        return sportsList[index]
    }
    
    func didSelectSport(at index: Int) {
        let selectedSport = sportsList[index]
        print("User selected: \(selectedSport.title)")
    }
}
