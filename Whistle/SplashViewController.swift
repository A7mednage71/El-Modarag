//
//  SplashViewController.swift
//  El-Modarag
//
//  Created by Ahmed Nageh on 19/05/2026.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var splashAppName: UILabel!
    @IBOutlet weak var splashLogo: UIImageView!
    @IBOutlet weak var splashBg: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        splashAppName.text = "WHISTLE"
        progressBar.progress = 0.0
        
        splashLogo.alpha = 0
        splashAppName.alpha = 0
        
        // decrease logo size to 20 % from his size
        splashLogo.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPulseAnimation { [weak self] in
            self?.startProgressLoading()
        }
    }
    
    // MARK: - Animations
    private func startPulseAnimation(completion: @escaping () -> Void) {

        let totalDuration = 1.5
        
        UIView.animateKeyframes(withDuration: totalDuration, delay: 0.1, options: [], animations: {
            
            // from 0% to 40% of the time
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                // show logo and name
                self.splashLogo.alpha = 1.0
                self.splashAppName.alpha = 1.0
                // 30% larger than its normal size
                self.splashLogo.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
            
            // from 40% to 70% of the time
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.3) {
                // CGAffineTransform.identity = normal status
                self.splashLogo.transform = CGAffineTransform.identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                self.splashLogo.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.05) {
                self.splashLogo.transform = CGAffineTransform.identity
            }
            
        }) { _ in
            completion()
        }
    }

    private func startProgressLoading() {
        var currentProgress: Float = 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            currentProgress += 0.015
            self.progressBar.setProgress(currentProgress, animated: true)
            
            if currentProgress >= 1.0 {
                timer.invalidate()
                self.navigateToOnBoardingScreen()
            }
        }
    }
    
    private func navigateToOnBoardingScreen() {
        
        guard let onBoardingScreen = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingScreen") else { return }
            
        if let window = UIApplication.shared.connectedScenes.first
            .flatMap({ ($0 as? UIWindowScene)?.windows.first }) {
            
            UIView.transition(with: window, duration: 0.5, options:.transitionCrossDissolve, animations: {
                    window.rootViewController = onBoardingScreen
                }, completion: nil)
            
        }
    }
}
