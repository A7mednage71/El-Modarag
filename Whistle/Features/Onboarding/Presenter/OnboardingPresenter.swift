//
//  OnboardingPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 21/05/2026.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getViewController(at index: Int) -> OnboardingChildViewController?
    func getIndex(before index: Int) -> Int?
    func getIndex(after index: Int) -> Int?
}

class OnboardingPresenter : OnboardingPresenterProtocol{
    
    private weak var view : OnboardingViewProtocol?
    
    let onboardingPages: [OnboardingModel] = [
        OnboardingModel(
            title: "FIFA WORLD CUP 2026",
            description: "Experience the historic 23rd edition like never before. Track every legendary moment, group standings, and knockout drama live from New York.",
            imageName: "onboarding_screen_1"
        ),
        OnboardingModel(
            title: "THE PULSE OF CRISTIANO",
            description: "Never miss a single heartbeat. Get ultra-fast notifications, elite performance stats, and live goal alerts for Ronaldo and the world's biggest icons.",
            imageName: "onboarding_screen_2"
        ),
        OnboardingModel(
            title: "ALL SPORTS, ONE FANZONE",
            description: "From football to basketball and beyond! Join El-Modarag community to predict matches, analysis with fans, and live your ultimate passion natively.",
            imageName: "onboarding_screen_3"
        )
    ]
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        if let firstVC = getViewController(at: 0) {
            view?.updateCurrentPage(childVC: firstVC)
        }
    }
    
    func getViewController(at index: Int) -> OnboardingChildViewController? {
        guard index >= 0 && index < onboardingPages.count else { return nil }
                
        let childVC = OnboardingChildViewController.instantiateFromStoryboard()
        
        let isLast :Bool = (index == onboardingPages.count - 1)
        
        let childPresenter = OnboardingChildPresenter(view: childVC, model: onboardingPages[index], isLastPage: isLast)
                
        childPresenter.nextAction = { [weak self] in
                    self?.handleNext(currentIndex: index)
        }
        childPresenter.skipAction = { [weak self] in
            self?.view?.navigateToMainScreen()
        }
                
        childVC.presenter = childPresenter
        childVC.pageIndex = index
                
        return childVC
    }
    
    func getIndex(before index: Int) -> Int? {
        let previousIndex = index - 1
        return previousIndex >= 0 ? previousIndex : nil
    }
    
    func getIndex(after index: Int) -> Int? {
        let nextIndex = index + 1
        return nextIndex < onboardingPages.count ? nextIndex : nil
    }
    
    private func handleNext(currentIndex: Int) {
        if let nextIndex = getIndex(after: currentIndex) {
            if let nextVC = getViewController(at: nextIndex) {
                view?.updateCurrentPage(childVC: nextVC)
            }
        }
        else {
               view?.navigateToMainScreen()
        }
    }
}
