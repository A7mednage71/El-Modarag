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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .all
        
        setupNavigationBarBackground()
        setupTableView()
        setupFullScreenBackground()
        
        presenter = FavoritesPresenter(view: self)
        presenter.viewDidLoad()
        
        self.title = "Favorites"
    }
    
    private func setupFullScreenBackground() {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "screen_bg")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        // No constraints needed – backgroundView is automatically sized to the table view's bounds
        tableView.backgroundView = backgroundImageView
    }
    
    private func setupTableView() {
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
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
}


extension FavoritesTableViewController {
        override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfFavorites ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        
        
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
                
        //  self?.presenter?.didRemoveFavorite(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            completionHandler(true)
        }
            
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
            
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}

extension FavoritesTableViewController: FavoritesViewProtocol {
    func reloadFavoritesData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showLoading() { print("Favorites Loading...") }
    func hideLoading() { print("Favorites Loaded.") }
}
