//
//  SplashViewController.swift
//  El-Modarag
//
//  Created by Ahmed Nageh on 19/05/2026.
//

import UIKit



protocol SplashViewProtocol: AnyObject {
    func startPulseAnimation(completion: @escaping () -> Void)
    func updateProgressBar(progress: Float)
    func navigateToOnBoardingScreen()
    func displayAppVersion()
}


class SplashViewController: UIViewController , SplashViewProtocol {

    @IBOutlet weak var splashLogo: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var versionLabel: UILabel!
    var presenter : SplashPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SplashPresenter(view: self)
        
        progressBar.progress = 0.0
        splashLogo.alpha = 0
        versionLabel.text = ""
        
        // decrease logo size to 20 % from his size
        splashLogo.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    // MARK: - Animations
    func startPulseAnimation(completion: @escaping () -> Void) {
        let totalDuration = 1.6
        
        UIView.animateKeyframes(withDuration: totalDuration, delay: 0.1, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.45) {
                self.splashLogo.alpha = 1.0
                
                let scaleTransform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                let rotateTransform = CGAffineTransform(rotationAngle: -.pi / 12) // -15 degrees
                
                self.splashLogo.transform = scaleTransform.concatenating(rotateTransform)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.3) {
                let scaleTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                let rotateTransform = CGAffineTransform(rotationAngle: .pi / 36) // +5 degrees
                
                self.splashLogo.transform = scaleTransform.concatenating(rotateTransform)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.splashLogo.transform = CGAffineTransform.identity
            }
            
        }) { _ in
            completion()
        }
    }
    
    func updateProgressBar(progress: Float) {
        
        self.progressBar.setProgress(progress, animated: true)
        
    }
    
    func displayAppVersion() {

        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        versionLabel.text = "Version \(appVersion) (\(buildNumber))"
    }
    
     func navigateToOnBoardingScreen() {
        
        guard let onBoardingScreen = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") else { return }
            
        if let window = UIApplication.shared.connectedScenes.first
            .flatMap({ ($0 as? UIWindowScene)?.windows.first }) {
            
        UIView.transition(with: window, duration: 0.5, options:.transitionCrossDissolve, animations: {
                    window.rootViewController = onBoardingScreen
                }, completion: nil)
            
        }
    }
}
