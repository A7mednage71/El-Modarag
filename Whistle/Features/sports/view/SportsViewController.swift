//
//  SportsViewController.swift
//  Whistle
//
//  Created by Omar on 22/05/2026.
//

import UIKit

struct Sport {
    let title: String
    let imageName: String
}

class SportsViewController: UICollectionViewController {
    
    var presenter : SportsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SportsPresenter(view: self)
        setupCollectionView()
        presenter?.viewDidLoad()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "screen_bg")
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 14 // vertical
            layout.minimumInteritemSpacing = 14 // Horizontal
            
            // calc cell width
            let padding: CGFloat = 16 * 3 // (Leading + Trailing + Space in-between)
            let availableWidth = UIScreen.main.bounds.width - padding
            let cellWidth = availableWidth / 2
            
            layout.itemSize = CGSize(width: cellWidth, height: 165)
            layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
            
            layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        }
    }
}

extension SportsViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfSports ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCategoryCollectionViewCell", for: indexPath) as! SportCategoryCollectionViewCell
        
        let category = presenter?.sport(at: indexPath.item)
        cell.sportImageView.image = UIImage(named: category!.imageName)
        cell.sportNameLabel.text = category?.title
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SportsHeaderReusableView", for: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
}


extension SportsViewController :SportsViewProtocol {
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
    func showError(message: String) {
    }
    
    func reloadSportsData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
