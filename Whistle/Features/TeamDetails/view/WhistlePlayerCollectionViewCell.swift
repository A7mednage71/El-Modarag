//
//  WhistlePlayerCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//

import Foundation
import UIKit
import SDWebImage

class WhistlePlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerInfoLabel: UILabel!
        
    @IBOutlet weak var shirtNumberContainer: UIView!
    @IBOutlet weak var shirtNumberLabel: UILabel!
        
    @IBOutlet weak var dividerView: UIView!
        
    @IBOutlet weak var ratingCardsLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var yellowCardsLabel: UILabel!
    @IBOutlet weak var yellowCardsValueLabel: UILabel!
    @IBOutlet weak var redCardsLabel: UILabel!
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
        
        let textLabels = [playerNameLabel, playerInfoLabel, ratingCardsLabel, yellowCardsLabel, redCardsLabel]
        textLabels.forEach { $0?.textAlignment = .natural }
    }
    
    func configure(with player: Player) {
        
        playerNameLabel.text = player.playerName ?? AppStrings.TeamDetails.unknownPlayer
        
        let rawPosition = player.playerType ?? "Forward"
        let localizedPosition = getLocalizedPosition(for: rawPosition)
        let age = player.playerAge ?? "\(Int.random(in: 19...35))"
        

        if !rawPosition.isEmpty && !age.isEmpty {
            playerInfoLabel.text = "\(localizedPosition) • \(AppStrings.TeamDetails.ageFormat(years: age))"
        } else {
            playerInfoLabel.text = rawPosition.isEmpty ? AppStrings.TeamDetails.ageFormat(years: age) : localizedPosition
        }
        
        redCardsLabel.text = AppStrings.TeamDetails.redCards
        yellowCardsLabel.text = AppStrings.TeamDetails.yellowCards
        ratingCardsLabel.text = AppStrings.TeamDetails.rating
        

        shirtNumberLabel.text = (player.playerNumber?.isEmpty == false) ? player.playerNumber : "\(Int.random(in: 1...99))"
        
        if let ratingStr = player.playerRating, !ratingStr.isEmpty {
            ratingValueLabel.text = ratingStr
        } else {
            ratingValueLabel.text = String(format: "%.1f", Double.random(in: 6.0...9.5))
        }

        yellowCardsValueLabel.text = (player.playerYellowCards?.isEmpty == false) ? player.playerYellowCards : "\(Int.random(in: 0...5))"
        redCardsValueLabel.text = (player.playerRedCards?.isEmpty == false) ? player.playerRedCards : "\(Int.random(in: 0...1))"
        
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
    
    private func getLocalizedPosition(for position: String) -> String {
        switch position.lowercased() {
        case "coach":         return AppStrings.TeamDetails.Positions.coach
        case "goalkeepers", "goalkeeper": return AppStrings.TeamDetails.Positions.goalkeepers
        case "defenders", "defender":   return AppStrings.TeamDetails.Positions.defenders
        case "midfielders", "midfielder": return AppStrings.TeamDetails.Positions.midfielders
        case "forwards", "forward":    return AppStrings.TeamDetails.Positions.forwards
        default:              return position
        }
    }
}
