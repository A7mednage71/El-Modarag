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
            title: AppStrings.Onboarding.title1,
            description: AppStrings.Onboarding.desc1,
            imageName: "onboarding_screen_1"
        ),
        OnboardingModel(
            title: AppStrings.Onboarding.title2,
            description: AppStrings.Onboarding.desc2,
            imageName: "onboarding_screen_2"
        ),
        OnboardingModel(
            title: AppStrings.Onboarding.title3,
            description: AppStrings.Onboarding.desc3,
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
