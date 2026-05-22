//
//  SportsViewController.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import UIKit

class SportsViewController: UIViewController, SportsViewProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var liveBannerView: UIView!
    
    var presenter: SportsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        
        presenter = SportsPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        
        if let banner = liveBannerView {
            banner.layer.cornerRadius = 20
            banner.backgroundColor = UIColor(red: 30/255, green: 40/255, blue: 30/255, alpha: 1.0)
            banner.layer.borderWidth = 1
            banner.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    // MARK: - SportsViewProtocol Methods
    
    func showLoading() {
        // يمكن إضافة UIActivityIndicatorView هنا
        print("Loading Data...")
    }
    
    func hideLoading() {
        print("Data Loaded.")
    }
    
    func reloadSportsData() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfSports
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCollectionViewCell
        
        let sport = presenter.sport(at: indexPath.row)
        cell.configure(with: sport)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSport(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let interItemSpacing: CGFloat = 16
        
        let availableWidth = collectionView.frame.width - (padding * 2) - interItemSpacing
        let cellWidth = availableWidth / 2
        
        return CGSize(width: cellWidth, height: cellWidth + 10) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
