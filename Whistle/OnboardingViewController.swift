//
//  OnboardingViewController.swift
//  El-Modarag
//
//  Created by Ahmed Nageh on 19/05/2026.
//

import UIKit


struct OnboardingModel {
    let title: String
    let description: String
    let imageName: String
}

class OnboardingViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let first = viewControllerAtIndex(index: 0){
            setViewControllers([first], direction:.forward, animated: true, completion: nil)
        }
    }
    
    
    private func viewControllerAtIndex(index:Int) -> OnboardingChildViewController?{
        
        if index < 0 || index >= onboardingPages.count{ return nil }
        
        if let childVC = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingChildScreen") as?
        OnboardingChildViewController{
            childVC.pageIndex = index
            childVC.pageModel = onboardingPages[index]
            
            childVC.skipHandler = { [weak self] in
                self?.navigateToMainScreen()
            }
            childVC.nextHandler = { [weak self] in
                self?.handelNext(currentIndex: index)
            }
            
            return childVC
        }
        
        return nil
    }
    
    private func handelNext(currentIndex:Int) {
        if currentIndex < 2 {
            if let nextVC = viewControllerAtIndex(index: currentIndex + 1){
                setViewControllers([nextVC], direction:.forward, animated: true, completion: nil)
            }
        }else{
            navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        
        guard let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") else { return }
            
        if let window = UIApplication.shared.connectedScenes.first
            .flatMap({ ($0 as? UIWindowScene)?.windows.first }) {
            
            UIView.transition(with: window, duration: 0.5, options:.transitionCrossDissolve, animations: {
                    window.rootViewController = mainScreen
                }, completion: nil)
            
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVc = viewController  as? OnboardingChildViewController  else { return nil }
        
       return viewControllerAtIndex(index: currentVc.pageIndex - 1 )
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVc = viewController as? OnboardingChildViewController else { return nil }
        
        return viewControllerAtIndex(index: currentVc.pageIndex + 1)
        
    }

}
