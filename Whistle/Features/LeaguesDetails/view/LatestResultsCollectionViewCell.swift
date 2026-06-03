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
      @IBOutlet weak var matchTimeLabel: UILabel!
    
    
    
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
        teamOneImageView.layer.cornerRadius = 16
        teamOneImageView.clipsToBounds = true
                 
        teamTwoImageView.contentMode = .scaleAspectFit
        teamTwoImageView.layer.cornerRadius = 16
        teamTwoImageView.clipsToBounds = true
    }
    
    func configure(with fixture: LeagueFixture) {

        teamOneNameLabel.text = fixture.eventHomeTeam ?? "Home Team"
        teamTwoNameLabel.text = fixture.eventAwayTeam ?? "Away Team"
            
            let date = fixture.eventDate ?? ""
            let time = fixture.eventTime ?? ""
            if !date.isEmpty && !time.isEmpty {
                matchDateLabel.text = date
                matchTimeLabel.text = time
            } else {
                matchDateLabel.text = "TBD"
                matchTimeLabel.text =  "--:--"
            }
            
            if let finalResult = fixture.eventFinalResult, finalResult.contains("-") {
                let scores = finalResult.components(separatedBy: "-")
                if scores.count == 2 {
                    teamOneScoreLabel.text = scores[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    teamTwoScoreLabel.text = scores[1].trimmingCharacters(in: .whitespacesAndNewlines)
                }
            } else {
                teamOneScoreLabel.text = "-"
                teamTwoScoreLabel.text = "-"
            }
            
            if let homeLogoString = fixture.homeTeamLogo, let homeURL = URL(string: homeLogoString) {
                teamOneImageView.sd_setImage(
                    with: homeURL,
                    placeholderImage: UIImage(named: "loading_img"),
                    options: [.continueInBackground, .lowPriority]
                )
            } else {
                teamOneImageView.image = UIImage(named: "failure_img")
            }
            
            if let awayLogoString = fixture.awayTeamLogo, let awayURL = URL(string: awayLogoString) {
                teamTwoImageView.sd_setImage(
                    with: awayURL,
                    placeholderImage: UIImage(named: "loading_img"),
                    options: [.continueInBackground, .lowPriority]
                )
            } else {
                teamTwoImageView.image = UIImage(named: "failure_img")
            }
        }
}
