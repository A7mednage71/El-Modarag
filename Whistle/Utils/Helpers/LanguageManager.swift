//
//  LanguageManager.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    private init() {}
    
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: "AppCurrentLanguage") ?? "en"
    }
    
    func setLanguage(_ language: String) {
        
        let direction: UISemanticContentAttribute = (language == "ar") ? .forceRightToLeft : .forceLeftToRight
        
        UserDefaults.standard.set(language, forKey: "AppCurrentLanguage")

        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        
        UIView.appearance().semanticContentAttribute = direction
        UITabBar.appearance().semanticContentAttribute = direction
        UINavigationBar.appearance().semanticContentAttribute = direction
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.semanticContentAttribute = direction
            
            if let tabBarController = window.rootViewController as? UITabBarController {
                let tabBar = tabBarController.tabBar
                tabBar.semanticContentAttribute = direction
                tabBar.subviews.forEach {
                    $0.semanticContentAttribute = direction
                    $0.setNeedsLayout()
                    $0.layoutIfNeeded()
                }
            }
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func restartApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft) {
            window.rootViewController = rootVC
        }
    }
}
