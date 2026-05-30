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
    func hideLoading()
}

class LeaguesTableViewController: UIViewController {
        
    @IBOutlet weak var leaguesTable: UITableView!
    
    private var presenter: LeaguesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullScreenBackground()
        setupTableView()
        presenter = LeaguesPresenter(view: self)
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
}

extension LeaguesTableViewController: LeaguesViewProtocol {
    
    func reloadLeaguesData() {
        DispatchQueue.main.async { [weak self] in
            self?.leaguesTable.reloadData()
        }
    }
    
    func showLoading() {
        print("Loading Leagues Flow Started...")
    }
    
    func hideLoading() {
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
