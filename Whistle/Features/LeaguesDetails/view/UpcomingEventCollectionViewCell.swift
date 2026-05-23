//
//  UpcomingEventCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 22/05/2026.
//

import UIKit

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
    }
}
