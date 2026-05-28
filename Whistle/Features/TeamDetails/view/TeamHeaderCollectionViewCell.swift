//
//  TeamHeaderCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 25/05/2026.
//

import UIKit

class TeamHeaderCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var TeamBgImage: UIImageView!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!

    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        gradientLayer.frame = contentView.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1.2
        self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.85).cgColor
        ]
        
        gradientLayer.locations = [0.0, 1.0]
        
        TeamBgImage.layer.addSublayer(gradientLayer)
    }
}
