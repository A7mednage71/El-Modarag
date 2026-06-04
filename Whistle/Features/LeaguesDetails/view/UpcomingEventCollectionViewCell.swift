//
//  UpcomingEventCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 22/05/2026.
//

import UIKit
import SDWebImage

class UpcomingEventCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cardOverlayView: UIView!
    
    @IBOutlet weak var liveBadgeView: UIView!
    
    @IBOutlet weak var liveBadgeDotView: UIView!
    @IBOutlet weak var matchCategoryLabel: UILabel!
    @IBOutlet weak var matchStatusLabel: UILabel!
    

    @IBOutlet weak var teamOneImageView: UIImageView!
    @IBOutlet weak var teamTwoImageView: UIImageView!
    @IBOutlet weak var teamOneNameLabel: UILabel!
    @IBOutlet weak var teamTwoNameLabel: UILabel!
    @IBOutlet weak var vsImageView: UIImageView!
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var calendarIconImageView: UIImageView!
    @IBOutlet weak var clockIconImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardStyle()
    }
    
    private func setupCardStyle() {

        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
        
        self.layer.borderWidth = 1.0
        if let neonLimeColor = UIColor(named: "LimeNeon") {
            self.layer.borderColor = neonLimeColor.cgColor
        } else {
            self.layer.borderColor = UIColor(red: 0.64, green: 1.0, blue: 0.0, alpha: 0.2).cgColor
        }
        
        liveBadgeView.layer.cornerRadius = liveBadgeView.frame.height / 2
        liveBadgeView.clipsToBounds = true
        
        liveBadgeDotView.layer.cornerRadius = 4
        liveBadgeDotView.clipsToBounds = true
        
        teamOneImageView.layer.cornerRadius = 16
        teamOneImageView.clipsToBounds = true
                
        teamTwoImageView.layer.cornerRadius = 16
        teamTwoImageView.clipsToBounds = true
    }
    
    func configure(with fixture: LeagueFixture) {

        teamOneNameLabel.text = fixture.eventHomeTeam ?? "Home Team"
        teamTwoNameLabel.text = fixture.eventAwayTeam ?? "Away Team"
        
        
        if let homeLogoString = fixture.homeTeamLogo, let homeURL = URL(string: homeLogoString) {
            teamOneImageView.sd_setImage(
                with: homeURL,
                placeholderImage: UIImage(named: "loading_img"),
                options: [.continueInBackground, .lowPriority],
            )
        } else {
            teamOneImageView.image = UIImage(named: "team_logo")
        }
        
        if let awayLogoString = fixture.awayTeamLogo, let awayURL = URL(string: awayLogoString) {
            teamTwoImageView.sd_setImage(
                with: awayURL,
                placeholderImage: UIImage(named: "loading_img"),
                options: [.continueInBackground, .lowPriority],
            )
        } else {
            teamTwoImageView.image = UIImage(named: "team_logo")
        }
        

        dateLabel.text = fixture.eventDate ?? "TBD"
        timeLabel.text = fixture.eventTime ?? "--:--"
    
        matchStatusLabel.text = fixture.eventStatus ?? "Upcoming"
        matchCategoryLabel.text = fixture.leagueName?.uppercased() ?? "CUP MATCH"
    
        vsImageView.image = UIImage(named: "vs_logo")
        calendarIconImageView.image = UIImage(systemName: "calendar")
        clockIconImageView.image = UIImage(systemName: "clock")
    }
}
