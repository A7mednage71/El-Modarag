//
//  LeaguesTableViewController.swift
//  Whistle
//
//  Created by Ahmed Nageh on 29/05/2026.
//

import UIKit

protocol LeaguesViewProtocol: AnyObject {
    func reloadLeaguesData()
    func showLoading()
    func showError(message: String)
    func hideLoading()
}

class LeaguesTableViewController: UIViewController {
        
    @IBOutlet weak var leaguesTable: UITableView!
    
    var presenter: LeaguesPresenterProtocol!
    let activityIndicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullScreenBackground()
        setupTableView()
        setupActivityIndicator()
        presenter.viewDidLoad()
    }
    
    private func setupFullScreenBackground() {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "screen_bg")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        view.backgroundColor = .clear
        leaguesTable.backgroundColor = .clear
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        leaguesTable.showsVerticalScrollIndicator = false
        leaguesTable.separatorStyle = .none
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}

extension LeaguesTableViewController: LeaguesViewProtocol {
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            WhistleAlertManager.showErrorAlert(
                on: self, title:  message,
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
    
    func reloadLeaguesData() {
        DispatchQueue.main.async { [weak self] in
            self?.leaguesTable.reloadData()
        }
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        print("Loading Leagues Flow Started...")
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        print("Leagues Flow Loaded Completely!")
    }
}

extension LeaguesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfLeagues ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        
        if let leagueItem = presenter?.league(at: indexPath.section) {
            cell.onFavButtonTapped = { [weak self] in
                guard let _ = self else { return }
                
                if LocalServices.isFavorite(leagueKey: leagueItem.leagueKey) {
                    LocalServices.deleteFavorite(leagueKey: leagueItem.leagueKey ?? 0)
                } else {
                    LocalServices.saveFavorite(league: leagueItem)
                }
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            }
                    
            let isFavorite = LocalServices.isFavorite(leagueKey: leagueItem.leagueKey)
            cell.configure(with: leagueItem , isFavorite: isFavorite)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectLeague(at: indexPath.section)
    }
}
