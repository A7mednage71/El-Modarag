//
//  SportsContract.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import Foundation

protocol SportsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadSportsData()
    func showError(message: String)
}

protocol SportsPresenterProtocol {
    var numberOfSports: Int { get }
    func viewDidLoad()
    func sport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}


