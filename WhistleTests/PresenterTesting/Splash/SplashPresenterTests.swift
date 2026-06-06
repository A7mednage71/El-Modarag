//
//  SplashPresenterTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

import XCTest
@testable import Whistle

class SplashPresenterTests: XCTestCase {
    
    var sut: SplashPresenter!
    var mockView: MockSplashView!
    
    override func setUp() {
        super.setUp()
        mockView = MockSplashView()
        sut = SplashPresenter(view: mockView)
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        super.tearDown()
    }
    
    func testViewDidAppear_TriggersAnimationAndAppVersion() {
        sut.viewDidAppear()
        
        XCTAssertTrue(mockView.isStartPulseAnimationCalled)
        XCTAssertTrue(mockView.isDisplayAppVersionCalled)
    }
    
    func testViewDidAppear_StartsProgressLoading() {
        
        let expectation = self.expectation(description: "Wait for timer ")
            
        sut.viewDidAppear()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 0.1)
            
        XCTAssertTrue(mockView.isUpdateProgressBarCalled)
        XCTAssertGreaterThan(mockView.lastProgressValue, 0.0)
    }
    
    
    func testCheckUserStatus_WhenOnboardingNotCompleted_NavigatesToOnboarding() {

        UserDefaultsManager.setOnboardingCompleted(false)

        sut.checkUserStatus()
        
        XCTAssertTrue(mockView.isNavigateToOnBoardingScreenCalled)
        XCTAssertFalse(mockView.isNavigateToMainScreenCalled)
    }
    
    func testCheckUserStatus_WhenOnboardingCompleted_NavigatesToMain() {

        UserDefaultsManager.setOnboardingCompleted(true)
        
        // When
        sut.checkUserStatus()
        
        // Then
        XCTAssertTrue(mockView.isNavigateToMainScreenCalled)
        XCTAssertFalse(mockView.isNavigateToOnBoardingScreenCalled)
    }
}
