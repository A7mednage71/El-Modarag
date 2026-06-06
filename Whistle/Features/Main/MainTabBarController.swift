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
        injectDependenciesToTabs() 
    }
    
    private func injectDependenciesToTabs() {
            
        let container = AppDelegate.container
            
        guard let viewControllers = self.viewControllers else { return }
            
        for viewController in viewControllers {

            if let navController = viewController as? UINavigationController {
                    print("")
                    if let sportsVC = navController.viewControllers.first as? SportsViewController {
                        sportsVC.presenter = container.makeSportsPresenter(view: sportsVC)
                    }
                    
                    else if let favoritesVC = navController.viewControllers.first as? FavoritesTableViewController {
                        favoritesVC.presenter = container.makeFavoritesPresenter(view: favoritesVC)
                    }
                    
                    else if let settingsVC = navController.viewControllers.first as? SettingsViewController {
                        settingsVC.presenter = container.makeSettingsPresenter(view: settingsVC)
                    }
                }
            }
        }
    
    private func setupTabItemsLocalization() {
        guard let items = tabBar.items, items.count >= 3 else { return }
            
        items[0].title = AppStrings.Sports.title
        items[1].title = AppStrings.Favorites.title
        items[2].title = AppStrings.Settings.title
    }
}
