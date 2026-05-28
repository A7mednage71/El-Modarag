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

    }
}
