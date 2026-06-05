//
//  SettingsViewController.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    private var presenter: SettingsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        
        setupFullScreenBackground()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = AppStrings.Settings.title
        self.navigationController?.navigationBar.tintColor = .white
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
        settingsTableView.backgroundColor = .clear
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .none
        settingsTableView.showsVerticalScrollIndicator = false
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        
        let title = presenter.getRowTitle()
        let icon = presenter.getRowIcon()
        
        cell.configure(title: title, iconName: icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            WhistleAlertManager.showLanguagePicker(on: self) { [weak self] selectedLanguageCode in
                self?.presenter.selectLanguage(to: selectedLanguageCode)
            }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension SettingsViewController: SettingsViewProtocol {
    
    func changeLanguageUI(to languageCode: String) {
        DispatchQueue.main.async {
            LanguageManager.shared.restartApp()
        }
    }
}
