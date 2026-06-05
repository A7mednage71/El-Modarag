//
//  SettingsTableViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellDesign()
    }

    private func setupCellDesign() {
        backgroundColor = .clear
        selectionStyle = .none
    
        self.contentView.layer.cornerRadius = 14
        self.contentView.clipsToBounds = true
            
        self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.contentView.layer.borderWidth = 1
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textAlignment = .natural
        
        iconImageView.tintColor = UIColor(named: "LimeNeon") ?? .systemGreen
        
        arrowButton.tintColor = .lightGray
    }
    
    func configure(title: String, iconName: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: iconName)
        
        let isArabic = Bundle.main.preferredLocalizations.first == "ar"
        let arrowIcon = isArabic ? "chevron.left" : "chevron.right"
        
        arrowButton.setImage(UIImage(systemName: arrowIcon), for: .normal)
        
    }
}
