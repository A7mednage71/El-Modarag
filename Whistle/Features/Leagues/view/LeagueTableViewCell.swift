//
//  LeagueTableViewCell.swift
//  Whistle
//
//  Created by Ahmed Nageh on 29/05/2026.
//

import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueCountryName: UILabel!
    @IBOutlet weak var arrowIconButton: UIButton!
    @IBOutlet weak var favIconButton: UIButton!
    
    
    var onFavButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // The system calls it whenever there is a change in sizes
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
        leagueCountryName.textColor = .white
        leagueNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
        arrowIconButton.tintColor = .lightGray
        
        favIconButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
    }
    
    // Target-Action Design Pattern
    // Objective-C Attribute
    @objc private func favButtonTapped() {
        onFavButtonTapped?()
    }
    
    func configure(with league: League , isFavorite : Bool) {
        leagueNameLabel.text = league.leagueName
        leagueCountryName.text = league.countryName != nil ? "📍 \(league.countryName!)" :  "🏆 Global"
            
        if let url = URL(string: league.leagueLogo ?? ""), url.scheme != nil {
            leagueImageView.sd_setImage(
                    with: url,
                    placeholderImage: UIImage(named: "loading_img"),
                    options: [.continueInBackground, .lowPriority]
                )
                
        }else {
            leagueImageView.image = UIImage(named: "team_logo")
        }
        
        let heartImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                
        favIconButton.setImage(heartImage, for: .normal)
        favIconButton.tintColor = isFavorite ? .systemRed : .white
    }
}
