//
//  SportCollectionViewCell.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        sportNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        sportNameLabel.textColor = .white
        
        gradientView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    func configure(with sport: Sport) {
        sportNameLabel.text = sport.name
        sportImageView.image = UIImage(named: sport.imageNamed)
    }
}
