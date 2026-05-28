//
//  WhistlePlayerCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//

import Foundation
import UIKit


class WhistlePlayerCollectionViewCell : UICollectionViewCell{

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerInfoLabel: UILabel!
        
    @IBOutlet weak var shirtNumberContainer: UIView!
    @IBOutlet weak var shirtNumberLabel: UILabel!
        
    @IBOutlet weak var dividerView: UIView!
        
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var yellowCardsValueLabel: UILabel!
    @IBOutlet weak var redCardsValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellDesign()
    }
    
    
     func setupCellDesign() {
         
         self.contentView.layer.cornerRadius = 16
         self.contentView.clipsToBounds = true
              
         self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
         self.contentView.layer.borderWidth = 1


            
        playerImageView.layer.cornerRadius = 27
        playerImageView.clipsToBounds = true
        playerImageView.contentMode = .scaleAspectFill
            
        shirtNumberContainer.layer.cornerRadius = 18
        shirtNumberContainer.clipsToBounds = true

    }
}
