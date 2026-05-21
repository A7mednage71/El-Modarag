//
//  OnboardingChildViewController.swift
//  El-Modarag
//
//  Created by Ahmed Nageh on 19/05/2026.
//

import UIKit


protocol OnboardingChildViewProtocol : AnyObject {
    func displayPageData(data:OnboardingModel, isLast: Bool)
}


class OnboardingChildViewController: UIViewController, OnboardingChildViewProtocol{

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presenter : OnboardingChildPresenterProtocol?
    var pageIndex: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        presenter?.viewDidLoad()
    }
    
    
    private func setupDesign() {
              
        // handel fonts
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Cairo-Bold", size: 32) ?? .systemFont(ofSize:32 , weight: .bold)
        
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont(name: "Cairo-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
        
        // handel get started button
        getStartedButton.layer.cornerRadius = 25

        getStartedButton.backgroundColor = UIColor(red: 0.66, green: 0.33, blue: 0.97, alpha: 1.0)
        getStartedButton.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
        getStartedButton.setTitleColor(.darkGray, for: .normal)
        
        skipButton.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
        
        skipButton.setTitleColor(.white, for: .normal)
        
        containerView.backgroundColor = UIColor.clear
        containerView.layer.cornerRadius = 24
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        containerView.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = containerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    
        containerView.insertSubview(blurEffectView, at: 0)
    }
    
    
    func displayPageData(data: OnboardingModel, isLast: Bool) {
        backgroundImage.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        if isLast {
            getStartedButton.setTitle("Get Started", for: .normal)
        } else {
            getStartedButton.setTitle("Next", for: .normal)
        }
        pageControl.currentPage = pageIndex
    }
    

    @IBAction func nextTapped(_ sender: Any) {
        presenter?.nextTapped()
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        presenter?.skipTapped()
    }
    
    static func instantiateFromStoryboard() -> OnboardingChildViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "OnBoardingChildScreen") as! OnboardingChildViewController
    }
}
