//
//  TeamDetailsViewController.swift
//  Whistle
//
//  Created by Ahmed Nageh on 28/05/2026.
//

import UIKit

enum TeamDetailsSection: Int, CaseIterable {
    case TeamImage = 0
    case Players = 1
}


protocol TeamDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayTeamHeader(with team: Team)
    func reloadPlayersList()
    func showEmptyState(message: String)
    func showError(message: String)
}


class TeamDetailsViewController: UICollectionViewController {
    
    var presenter :TeamDetailsPresenterProtocol?
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter(view: self)
        setupCollectionView()
        presenter?.viewDidLoad()
    }
    
    private func setupCollectionView() {
        // Compositional Layout
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "screen_bg")
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TeamDetailsSection.allCases.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = TeamDetailsSection(rawValue: section) else { return 0 }

        switch sectionType {
            case .TeamImage:
               return 1
            case .Players:
               let count = presenter?.numberOfPlayers ?? 0
               return count == 0 ? 1 : count  // 1 -> to handel empty
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let sectionType = TeamDetailsSection(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
        switch sectionType {
            case .TeamImage:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamHeaderCollectionViewCell", for: indexPath) as! TeamHeaderCollectionViewCell
                return cell
                
            case .Players:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhistlePlayerCollectionViewCell", for: indexPath) as! WhistlePlayerCollectionViewCell
                
                cell.contentView.viewWithTag(999)?.removeFromSuperview()
                let count = presenter?.numberOfPlayers ?? 0
                
                if count > 0 {
                    cell.contentView.subviews.forEach { $0.isHidden = false }
                }else{
                    cell.contentView.subviews.forEach { $0.isHidden = true }
                    cell.contentView.backgroundColor = .clear
                    cell.contentView.layer.borderColor = UIColor.clear.cgColor
                    cell.contentView.layer.borderWidth = 0
                    let emptyState = WhistleReusableEmptyView(
                            frame: cell.contentView.bounds,
                            message: "No players available in this team squad.",
                            imageName: "empty_state"
                        )
                    emptyState.tag = 999
                    emptyState.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    cell.contentView.addSubview(emptyState)
                }
                return cell
        }
    }
}

extension TeamDetailsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = TeamDetailsSection(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .TeamImage: return self.createTeamImageSection()
            case .Players:   return self.createTeamPlayersSection()
            }
        }
    }
    
    private func createTeamImageSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
    
    private func createTeamPlayersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let count = presenter?.numberOfPlayers ?? 0
        let height: CGFloat = count == 0 ? 350 : 190
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16)
        section.interGroupSpacing = 14
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TeamDetailsHeaderReusableView", for: indexPath)
            
            guard let sectionType = TeamDetailsSection(rawValue: indexPath.section) else { return headerView }
 
            if let titleLabel = headerView.viewWithTag(200) as? UILabel {
                switch sectionType {
                case .Players:  titleLabel.text = "Team Players"
                case .TeamImage:  titleLabel.text = "Team"
                }
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}


extension TeamDetailsViewController : TeamDetailsViewProtocol{

    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func displayTeamHeader(with team: Team) {
    }
    
    func reloadPlayersList() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func showEmptyState(message: String) {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            WhistleAlertManager.showErrorAlert(
                on: self, title: "Error Occur..!!",
                message: message,
                okayHandler: {},
                retryHandler: {
                }
            )
        }
    }
    
}
