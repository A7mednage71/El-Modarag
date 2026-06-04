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
    
    func configure(with player: Player) {
        
        playerNameLabel.text = player.playerName ?? "Unknown Player"
        
        let position = player.playerType ?? "Forward"
        let age = player.playerAge ?? "\(Int.random(in: 19...35))"
        
        if !position.isEmpty && !age.isEmpty {
            playerInfoLabel.text = "\(position) • \(age) Yrs"
        } else {
            playerInfoLabel.text = position.isEmpty ? "\(age) Yrs" : position
        }
        
        if let shirtNum = player.playerNumber, !shirtNum.isEmpty {
            shirtNumberLabel.text = shirtNum
        } else {
            shirtNumberLabel.text = "\(Int.random(in: 1...99))"
        }

        if let ratingStr = player.playerRating, !ratingStr.isEmpty {
            ratingValueLabel.text = ratingStr
        } else {
            let randomRating = Double.random(in: 6.0...9.5)
            ratingValueLabel.text = String(format: "%.1f", randomRating)
        }

        if let yellowCards = player.playerYellowCards, !yellowCards.isEmpty {
            yellowCardsValueLabel.text = yellowCards
        } else {
            yellowCardsValueLabel.text = "\(Int.random(in: 0...5))"
        }
        
        if let redCards = player.playerRedCards, !redCards.isEmpty {
            redCardsValueLabel.text = redCards
        } else {
            redCardsValueLabel.text = "\(Int.random(in: 0...1))"
        }
        
        if let urlString = player.playerImage, let url = URL(string: urlString), url.scheme != nil {
            playerImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "loading_img"),
                options: [.continueInBackground, .lowPriority]
            )
        } else {
            playerImageView.image = UIImage(named: "player")
        }
    }
}
