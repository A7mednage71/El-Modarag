//
//  FavoritesTableViewController.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reloadFavoritesData()
    func showLoading()
    func hideLoading()
}

class FavoritesTableViewController: UITableViewController {

    private var presenter: FavoritesPresenterProtocol!
    let activityIndicator = UIActivityIndicatorView()
    private var emptyStateView: WhistleReusableEmptyView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .all
        
        setupNavigationBarBackground()
        setupTableView()
        setupFullScreenBackground()
        setupActivityIndicator()
        
        presenter = FavoritesPresenter(view: self)
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    private func setupFullScreenBackground() {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "screen_bg")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        tableView.backgroundView = backgroundImageView
    }
    
    private func setupTableView() {
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    private func setupNavigationBarBackground() {
        guard let image = UIImage(named: "screen_bg") else { return }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.backgroundImage = image
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = .white

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func showEmptyStateIfNeeded() {
        guard emptyStateView == nil else { return }
        
        let emptyView = WhistleReusableEmptyView(
            frame: .zero,
            title: "No Favorites Yet!",
            message: "Your stadium is quiet. Add your favorite leagues to start tracking the live action and scores!",
            imageName: "empty_state"
        )
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        if let targetContainer = navigationController?.view {
            targetContainer.addSubview(emptyView)
            emptyStateView = emptyView
            
            NSLayoutConstraint.activate([
                emptyView.topAnchor.constraint(equalTo: targetContainer.topAnchor),
                emptyView.bottomAnchor.constraint(equalTo: targetContainer.bottomAnchor),
                emptyView.leadingAnchor.constraint(equalTo: targetContainer.leadingAnchor),
                emptyView.trailingAnchor.constraint(equalTo: targetContainer.trailingAnchor)
            ])
        }
    }
    
    private func removeEmptyStateIfNeeded() {
        emptyStateView?.removeFromSuperview()
        emptyStateView = nil
    }
}

// MARK: - TableView DataSource & Delegate
extension FavoritesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfFavorites ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        
        if let leagueItem = presenter?.favoriteItem(at: indexPath.section) {
            cell.configure(with: leagueItem)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectFavorite(at: indexPath.section)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            
            guard let self = self else {
                completionHandler(false)
                return
            }
            
            WhistleAlertManager.showConfirmationAlert(
                on: self,
                title: "Delete Favorite",
                message: "Are you sure you want to remove this league?",
                okayTitle: "Yes, Delete",
                cancelTitle: "No",
                okayHandler: { [weak self] in
                    guard let self = self else { return }
                    self.presenter?.didRemoveFavorite(at: indexPath.section)
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
                    if self.presenter?.numberOfFavorites == 0 {
                        self.showEmptyStateIfNeeded()
                    }
                    completionHandler(true)
                },
                cancelHandler: {
                    completionHandler(false)
                }
            )
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
            
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}

// MARK: - Presenter View Protocol Implementation
extension FavoritesTableViewController: FavoritesViewProtocol {
    
    func reloadFavoritesData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            if self.presenter?.numberOfFavorites == 0 {
                self.showEmptyStateIfNeeded()
            } else {
                self.removeEmptyStateIfNeeded()
            }
        }
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        print("Favorites Loading...")
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        print("Favorites Loaded.")
    }
}
