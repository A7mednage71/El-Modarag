//
//   LeaguesDetailsViewController.swift
//   Whistle
//
//   Created by Ahmed Nageh on 22/05/2026.
//

import UIKit

enum Section: Int, CaseIterable {
    case upcomingEvents = 0
    case latestResults = 1
    case teamsList = 2
}


class LeaguesDetailsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
}


extension LeaguesDetailsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .upcomingEvents: return self.createUpcomingSection()
            case .latestResults:  return self.createLatestResultsSection()
            case .teamsList:      return self.createTeamsSection()
            }
        }
    }
    
    private func createUpcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 24, trailing: 16)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Setup Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        // Scale Animation Handler
        section.visibleItemsInvalidationHandler = { (visibleItems, offset, layoutEnvironment) in
            let groupWidth: CGFloat = 350.0
            let containerWidth = layoutEnvironment.container.contentSize.width
            let centerX = offset.x + (containerWidth / 2.0)
            
            visibleItems.forEach { item in
                guard item.representedElementKind != UICollectionView.elementKindSectionHeader else { return }
                
                let distanceFromCenter = abs(item.center.x - centerX)
                let minScale: CGFloat = 0.94
                let maxScale: CGFloat = 1.0
                
                let ratio = min(distanceFromCenter / groupWidth, 1.0)
                let scale = maxScale - (ratio * (maxScale - minScale))
                
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                
                let minAlpha: CGFloat = 0.85
                let alpha = 1.0 - (ratio * (1.0 - minAlpha))
                item.alpha = alpha
            }
        }
        
        return section
    }
    
    private func createLatestResultsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 24, trailing: 16)
        section.interGroupSpacing = 12
        
        // Setup Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createTeamsSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top
           )
        section.boundarySupplementaryItems = [sectionHeader]
        return section

       }

}


extension LeaguesDetailsViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        switch sectionType {
        case .upcomingEvents: return 5
        case .latestResults:  return 6
        case .teamsList:      return 8
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
            
        switch sectionType {
        case .upcomingEvents:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCollectionViewCell", for: indexPath) as! UpcomingEventCollectionViewCell
            return cell
        case .latestResults:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultsCollectionViewCell", for: indexPath) as! LatestResultsCollectionViewCell
            return cell
        case .teamsList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath)
            
            guard let sectionType = Section(rawValue: indexPath.section) else { return headerView }
            
            if let titleLabel = headerView.viewWithTag(100) as? UILabel {
                switch sectionType {
                case .upcomingEvents: titleLabel.text = "Upcoming Events"
                case .latestResults:  titleLabel.text = "Latest Results"
                case .teamsList:      titleLabel.text = "Participating Teams"
                }
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}
