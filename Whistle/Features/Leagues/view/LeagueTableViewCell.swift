//
//  LeagueTableViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 29/05/2026.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var arrowIconButton: UIImageView!
    @IBOutlet weak var favIconButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImageView.layer.cornerRadius = leagueImageView.frame.height / 2
    }
    
    private func setupCellUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    
        self.contentView.layer.cornerRadius = 14
        self.contentView.clipsToBounds = true
            
        self.contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.contentView.layer.borderWidth = 1
            
        leagueImageView.clipsToBounds = true
        leagueImageView.contentMode = .scaleAspectFill
            
        leagueNameLabel.textColor = .white
        leagueNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
        arrowIconButton.tintColor = .lightGray
        favIconButton.tintColor = .systemRed
    }
}
