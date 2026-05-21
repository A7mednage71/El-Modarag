//
//  OnboardingChildPresenter.swift
//  Whistle
//
//  Created by Ahmed Nageh on 21/05/2026.
//

import Foundation


protocol OnboardingChildPresenterProtocol : AnyObject {
    func viewDidLoad()
    func nextTapped()
    func skipTapped()
}


class OnboardingChildPresenter : OnboardingChildPresenterProtocol{
    
    private weak var view : OnboardingChildViewProtocol?
    private let model : OnboardingModel
    private let isLastPage: Bool
    
    var nextAction :(() -> Void)?
    var skipAction :(() -> Void)?
    
    init(view: OnboardingChildViewProtocol, model: OnboardingModel, isLastPage: Bool) {
        self.view = view
        self.model = model
        self.isLastPage = isLastPage
    }
    
    func viewDidLoad() {
        view?.displayPageData(data: model, isLast: isLastPage)
    }
    
    func nextTapped() {
        nextAction?()
    }
    
    func skipTapped() {
        skipAction?()
    }
    
    
}
