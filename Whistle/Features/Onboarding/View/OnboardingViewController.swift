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


protocol OnboardingViewProtocol: AnyObject {
    func updateCurrentPage(childVC: OnboardingChildViewController)
    func navigateToMainScreen()
}


class OnboardingViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource , OnboardingViewProtocol {
    
    var presenter : OnboardingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        presenter = OnboardingPresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    func updateCurrentPage(childVC: OnboardingChildViewController) {
        setViewControllers([childVC], direction:.forward, animated: true, completion: nil)
    }

    
    func navigateToMainScreen() {
        
        guard let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") else { return }
            
        if let window = UIApplication.shared.connectedScenes.first
            .flatMap({ ($0 as? UIWindowScene)?.windows.first }) {
            
            UIView.transition(with: window, duration: 0.5, options:.transitionCrossDissolve, animations: {
                    window.rootViewController = mainScreen
                }, completion: nil)
            
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVc = viewController  as? OnboardingChildViewController  else { return nil }
        guard let previousIndex = presenter?.getIndex(before: currentVc.pageIndex) else { return nil }
        
        return presenter?.getViewController(at: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVc = viewController as? OnboardingChildViewController else { return nil }
        guard let nextIndex = presenter?.getIndex(after: currentVc.pageIndex) else { return nil }
        
        return presenter?.getViewController(at: nextIndex)

    }

}
