//
//  LatestResultsCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//

import UIKit

class LatestResultsCollectionViewCell: UICollectionViewCell {
    
      @IBOutlet weak var backgroundImageView: UIImageView!
      @IBOutlet weak var cardOverlayView: UIView!
        
      @IBOutlet weak var teamOneImageView: UIImageView!
      @IBOutlet weak var teamOneNameLabel: UILabel!
        
      @IBOutlet weak var teamTwoImageView: UIImageView!
      @IBOutlet weak var teamTwoNameLabel: UILabel!
        
      @IBOutlet weak var teamOneScoreLabel: UILabel!
      @IBOutlet weak var teamTwoScoreLabel: UILabel!
      @IBOutlet weak var matchDateLabel: UILabel!
        
      override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
      }
        
     private func setupCellUI() {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
            
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
         
        self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.contentView.layer.borderWidth = 1
    
        teamOneImageView.contentMode = .scaleAspectFit
        teamTwoImageView.contentMode = .scaleAspectFit
    }
}
