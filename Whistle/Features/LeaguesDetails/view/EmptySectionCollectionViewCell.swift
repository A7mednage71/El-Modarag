//
//  EmptySectionCollectionViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 04/06/2026.
//

import UIKit

class EmptySectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(title: String, message: String, imageName: String) {
        titleLabel.text = title
        messageLabel.text = message
        errorImageView.image = UIImage(systemName: imageName)
    }
    
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
    
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.layer.cornerRadius = 16
        errorImageView.clipsToBounds = true
         errorImageView.tintColor = UIColor.systemGreen.withAlphaComponent(0.65)
    }
}
