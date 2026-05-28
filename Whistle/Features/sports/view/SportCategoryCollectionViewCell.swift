//
//  SportCollectionViewCell.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import UIKit

class SportCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
                
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "LimeNeon")?.cgColor
        sportNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        sportNameLabel.textColor = .white
    }
    
    func configure(with sport: Sport) {
        sportNameLabel.text = sport.title
        sportImageView.image = UIImage(named: sport.imageName)
    }
}
