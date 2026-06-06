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


protocol LeaguesDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func refreshCollectionView()
    func navigateToTeamDetailsScreen(with team: Team , selectedSport:Sport)
    func showError(message: String)
}


class LeaguesDetailsViewController: UICollectionViewController {
    
    var presenter : LeaguesDetailsPresenterProtocol?
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
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
}


extension LeaguesDetailsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) ->NSCollectionLayoutSection? in
        guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
        let itemsCount = self.presenter?.numberOfItems(in: sectionType) ?? 0
        if itemsCount == 0 {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize, elementKind:UICollectionView.elementKindSectionHeader,alignment: .top
                )
            section.boundarySupplementaryItems = [sectionHeader]
                
            return section
        }
            
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
        let realCount = presenter?.numberOfItems(in: sectionType) ?? 0
        if realCount == 0 {
            return activityIndicator.isAnimating ? 0 : 1
        }
        return realCount
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionType = Section(rawValue: indexPath.section) else { return }
        
        let itemsCount = presenter?.numberOfItems(in: sectionType) ?? 0
        guard itemsCount > 0 else { return }
        
        let isTennis = presenter?.getSelectedSport == .tennis
        
        if sectionType == .teamsList && !isTennis {
            presenter?.didSelectTeam(at: indexPath.item)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        let itemsCount = presenter?.numberOfItems(in: sectionType) ?? 0
            
        if itemsCount == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptySectionCollectionViewCell", for: indexPath) as! EmptySectionCollectionViewCell
                
                switch sectionType {
                   case .upcomingEvents:
                       cell.configure(title: AppStrings.LeagueDetails.EmptyState.noUpcomingTitle,
                               message: AppStrings.LeagueDetails.EmptyState.noUpcomingMessage,
                               imageName: "calendar.badge.clock")
                   case .latestResults:
                       cell.configure(title: AppStrings.LeagueDetails.EmptyState.noResultsTitle,
                                message: AppStrings.LeagueDetails.EmptyState.noResultsMessage,
                               imageName: "doc.text.magnifyingglass")
                   case .teamsList:
                       let isTennis = presenter?.getSelectedSport == .tennis
                       let title = isTennis ? AppStrings.LeagueDetails.EmptyState.noPlayersTitle : AppStrings.LeagueDetails.EmptyState.noTeamsTitle
                       cell.configure(title: title,
                               message: AppStrings.LeagueDetails.EmptyState.noTeamsMessage,
                               imageName: "person.3.sequence")
                 }
                
                return cell
            }
        
        switch sectionType {
        case .upcomingEvents:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCollectionViewCell", for: indexPath) as! UpcomingEventCollectionViewCell
            if let fixture = presenter?.upcomingMatch(at: indexPath.item) {
                   cell.configure(with: fixture)
            }
            return cell
        case .latestResults:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultsCollectionViewCell", for: indexPath) as! LatestResultsCollectionViewCell
            if let fixture = presenter?.latestResult(at: indexPath.item) {
                   cell.configure(with: fixture)
            }
            return cell
        case .teamsList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            if let team = presenter?.team(at: indexPath.item){
                cell.configure(with: team)
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath)
            
            guard let sectionType = Section(rawValue: indexPath.section) else { return headerView }
    
            
            let itemsCount = presenter?.numberOfItems(in: sectionType) ?? 0
            let sport = presenter?.getSelectedSport
            
            if itemsCount == 0 && activityIndicator.isAnimating {
                headerView.frame = .zero
                return headerView
            }
            
            if let titleLabel = headerView.viewWithTag(100) as? UILabel {
                titleLabel.textAlignment = .natural
                
                switch sectionType {
                    case .upcomingEvents: titleLabel.text = AppStrings.LeagueDetails.upcomingEvents
                    case .latestResults:  titleLabel.text = AppStrings.LeagueDetails.latestResults
                    case .teamsList:      titleLabel.text = (sport == .tennis) ? AppStrings.LeagueDetails.players : AppStrings.LeagueDetails.participatingTeams
                    }
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}


extension LeaguesDetailsViewController : LeaguesDetailsViewProtocol{
    
    func navigateToTeamDetailsScreen(with team: Team , selectedSport:Sport) {
        guard team.teamKey != nil else {
            showError(message: AppStrings.Alerts.playersNavError)
            return
        }
        
        guard let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier:"TeamDetailsViewController")as? TeamDetailsViewController else {
            return
        }
        
        let teamDetailsPresenter = AppDelegate.container.makeTeamDetailsPresenter(
            view: teamDetailsVC,
            teamData: team,
            selectedSport: selectedSport
        )

        teamDetailsVC.presenter = teamDetailsPresenter
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func refreshCollectionView() {
        self.collectionView.reloadData()
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            WhistleAlertManager.showErrorAlert(
                on: self, title:AppStrings.Alerts.errorTitle,
                message: message,
                okayHandler: {
                    self.navigationController?.popViewController(animated: true)
                },
                retryHandler: {
                    self.presenter?.viewDidLoad()
                }
            )
        }
    }
}
