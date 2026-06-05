//
//  SportsHeaderReusableView.swift
//  Whistle
//
//  Created by Omar on 05/06/2026.
//

import UIKit

class SportsHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenSubtitleLabel: UILabel!
    
    func configureLocalization() {
        
        screenTitleLabel.text = AppStrings.Sports.title
        screenSubtitleLabel.text = AppStrings.Sports.subtitle
        
        screenTitleLabel.textAlignment = .natural
        screenSubtitleLabel.textAlignment = .natural
    }
}
