//
//  UserDefaultsManager.swift
//  Whistle
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation

import Foundation

class UserDefaultsManager {
    
    private init() {}
    
    private enum Keys {
        static let isOnboardingHide = "IsOnBoardingHide"
    }
    
    private static let defaults = UserDefaults.standard
    
    static func setOnboardingCompleted(_ completed: Bool) {
        defaults.set(completed, forKey: Keys.isOnboardingHide)
    }
    
    static func isOnboardingCompleted() -> Bool {
        return defaults.bool(forKey: Keys.isOnboardingHide)
    }
    
    static func clearAllData() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(" [UserDefaults] : All cached user defaults cleared!")

    }
}
