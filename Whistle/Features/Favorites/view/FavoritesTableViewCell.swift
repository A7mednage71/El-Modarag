//
//  FavoritesTableViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardOverlayView: UIView!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var arrowIconButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    override func layoutSubviews() {
        // layoutSubviews : is the most suitable place to write the codes for circles and Corner Radius because it is executed after the view takes its final real size on the screen.
        super.layoutSubviews()
        leagueImageView.layer.cornerRadius = leagueImageView.frame.height / 2
    }
    
    private func setupCellUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    
        self.cardOverlayView.layer.cornerRadius = 14
        self.cardOverlayView.clipsToBounds = true
            
        self.cardOverlayView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.cardOverlayView.layer.borderWidth = 1
            
        leagueImageView.clipsToBounds = true
        leagueImageView.contentMode = .scaleAspectFill
            
        leagueNameLabel.textColor = .white
        leagueNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
        arrowIconButton.tintColor = .lightGray
    }
}
