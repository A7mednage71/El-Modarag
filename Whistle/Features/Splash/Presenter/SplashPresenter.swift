//
//  SplashPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 20/05/2026.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}


class SplashPresenter: SplashPresenterProtocol {
    
    private weak var view: SplashViewProtocol?
    private var currentProgress: Float = 0.0
    private var timer: Timer?
    
    init(view: SplashViewProtocol) {
        self.view = view
    }
    
    func viewDidAppear() {
        view?.startPulseAnimation { [weak self] in
            self?.startProgressLoading()
        }
    }
    
    private func startProgressLoading() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.currentProgress += 0.015
            self.view?.updateProgressBar(progress: self.currentProgress)
            
            if self.currentProgress >= 1.0 {
                timer.invalidate()
                self.view?.navigateToOnBoardingScreen()
            }
        }
    }
}
