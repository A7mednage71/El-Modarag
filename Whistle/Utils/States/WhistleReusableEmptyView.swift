//
//  WhistleReusableEmptyView.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//
import UIKit

class WhistleReusableEmptyView: UIView {
    
    init(frame: CGRect,title: String, message: String, imageName: String) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        let icon = UIImageView()
        icon.image = UIImage(named: imageName)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white.withAlphaComponent(0.9)
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white.withAlphaComponent(0.9)
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stack = UIStackView(arrangedSubviews: [icon,titleLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 100),
            icon.heightAnchor.constraint(equalToConstant: 100),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
