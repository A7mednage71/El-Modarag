//
//  SettingsPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func changeLanguageUI(to languageCode: String)
}

protocol SettingsPresenterProtocol: AnyObject {
    var numberOfRows: Int { get }
    func getRowTitle() -> String
    func getRowIcon() -> String
    func didSelectLanguageRow()
    func selectLanguage(to code: String)
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    
    var numberOfRows: Int {
        return 1
    }
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func getRowTitle() -> String {
        return AppStrings.Settings.languageRow
    }
    
    func getRowIcon() -> String {
        return "globe"
    }
    
    func didSelectLanguageRow() {

    }
    
    func selectLanguage(to code: String) {
        LanguageManager.shared.setLanguage(code)
        view?.changeLanguageUI(to: code)
    }
}
