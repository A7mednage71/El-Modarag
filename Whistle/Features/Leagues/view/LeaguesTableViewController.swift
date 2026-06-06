//
//  LeaguesTableViewController.swift
//  Whistle
//
//  Created by Omar on 29/05/2026.
//

import UIKit

protocol LeaguesViewProtocol: AnyObject {
    func reloadLeaguesData()
    func navigateToLeaguesScreen(sport: Sport,leagueName: String,leagueId : Int?)
    func showLoading()
    func showError(message: String)
    func hideLoading()
}

class LeaguesTableViewController: UIViewController {
        
    @IBOutlet weak var leaguesHeaderLabel: UILabel!
    @IBOutlet weak var leaguesTable: UITableView!
    
    var presenter: LeaguesPresenterProtocol!
    let activityIndicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackButton()
        setupFullScreenBackground()
        setupTableView()
        setupActivityIndicator()
        presenter.viewDidLoad()
    }
    
    private func setupFullScreenBackground() {
        leaguesHeaderLabel.text = AppStrings.Leagues.title
        
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
    
    
    private func setUpBackButton() {
        self.title = presenter.getSelectedSport.title
        self.navigationController?.navigationBar.tintColor = .white
    }
}

extension LeaguesTableViewController: LeaguesViewProtocol {
    
    func navigateToLeaguesScreen(sport: Sport, leagueName: String , leagueId: Int?) {
        guard let validLeagueId = leagueId else {
            showError(message: AppStrings.Leagues.navError)
            return
        }
        
        guard let leaguesVC = self.storyboard?.instantiateViewController(withIdentifier:"LeaguesDetailsViewController")as? LeaguesDetailsViewController else {
            return
        }
        
        let detailsPresenter = AppDelegate.container.makeLeaguesDetailsPresenter(
                    view: leaguesVC,
                    selectedSport: sport,
                    leagueId: validLeagueId
                )
        
        self.navigationItem.backButtonTitle = ""
        leaguesVC.title = leagueName
    
        
        leaguesVC.presenter = detailsPresenter
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            WhistleAlertManager.showErrorAlert(
                on: self, title: AppStrings.Alerts.errorTitle,
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
                guard let sportType = self?.presenter.getSelectedSport else { return  }
                self?.presenter?.toggleFavorite(at: indexPath.section)
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            }
                    
            let isFavorite = presenter?.isLeagueFavorite(at: indexPath.section) ?? false
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
