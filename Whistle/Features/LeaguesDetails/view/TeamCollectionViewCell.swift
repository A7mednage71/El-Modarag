//
//  TeamCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 23/05/2026.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
            
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
            
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
             
        self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.contentView.layer.borderWidth = 1
        
        teamImageView.layer.cornerRadius = 16
        teamImageView.clipsToBounds = true

    }
    
    func configure(with team: Team) {
        
        teamNameLabel.text = team.teamName
        
        if let teamLogo = team.teamLogo, let homeURL = URL(string: teamLogo) {
            teamImageView.sd_setImage(
                with: homeURL,
                placeholderImage: UIImage(named: "loading_img"),
                options: [.continueInBackground, .lowPriority]
            )
        } else {
            teamImageView.image = UIImage(named: "team_logo")
        }
        
    }

}
