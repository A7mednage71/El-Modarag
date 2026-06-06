//
//  MockSplashView.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import Foundation
@testable import Whistle

class MockSplashView: SplashViewProtocol {
    
    var isStartPulseAnimationCalled = false
    var isDisplayAppVersionCalled = false
    var isUpdateProgressBarCalled = false
    var lastProgressValue: Float = 0.0
    var isNavigateToMainScreenCalled = false
    var isNavigateToOnBoardingScreenCalled = false
    
    func startPulseAnimation(completion: @escaping () -> Void) {
        isStartPulseAnimationCalled = true
        completion()
    }
    
    func displayAppVersion() {
        isDisplayAppVersionCalled = true
    }
    
    func updateProgressBar(progress: Float) {
        isUpdateProgressBarCalled = true
        lastProgressValue = progress
    }
    
    func navigateToMainScreen() {
        isNavigateToMainScreenCalled = true
    }
    
    func navigateToOnBoardingScreen() {
        isNavigateToOnBoardingScreenCalled = true
    }
}
