//
//  MainTabBarController.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabItemsLocalization()
    }
    
    private func setupTabItemsLocalization() {
        let isArabic = Bundle.main.preferredLocalizations.first == "ar"
        
        if isArabic {
            tabBar.items?[0].title = AppStrings.Sports.title
            tabBar.items?[1].title = AppStrings.Favorites.title
        } else {
            tabBar.items?[0].title = AppStrings.Favorites.title
            tabBar.items?[1].title =  AppStrings.Sports.title
        }
    }
}
