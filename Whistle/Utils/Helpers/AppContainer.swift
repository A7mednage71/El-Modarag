//
//  AppContainer.swift
//  Whistle
//
//  Created by Omar on 06/06/2026.
//

import Foundation

class AppContainer {
 
    var localService: LocalServicesProtocol {
        return LocalServices(databaseManager: CoreDataManager.shared)
    }
    
    var networkClient: NetworkClientProtocol {
        return NetworkClient()
    }
    
    var networkService: NetworkServicesProtocol {
        return NetworkServices(client: networkClient)
    }
    

    func makeSplashPresenter(view: SplashViewProtocol) -> SplashPresenterProtocol {
        return SplashPresenter(view: view)
    }

    func makeOnboardingPresenter(view: OnboardingViewProtocol) -> OnboardingPresenterProtocol {
        return OnboardingPresenter(view: view)
    }
    
    func makeSportsPresenter(view: SportsViewProtocol) -> SportsPresenterProtocol {
            return SportsPresenter(view: view)
    }
        
    func makeFavoritesPresenter(view: FavoritesViewProtocol) -> FavoritesPresenterProtocol {
        return FavoritesPresenter(view: view, localService: self.localService)
    }
        
    func makeSettingsPresenter(view: SettingsViewProtocol) -> SettingsPresenterProtocol {
        return SettingsPresenter(view: view)
    }
    
    func makeLeaguesDetailsPresenter(view: LeaguesDetailsViewProtocol,
                                         selectedSport: Sport,
                                         leagueId: Int) -> LeaguesDetailsPresenterProtocol {
            
            return LeaguesDetailsPresenter(
                view: view,
                selectedSport: selectedSport,
                leagueId: leagueId,
                networkService: self.networkService
            )
    }
    
    func makeLeaguesPresenter(view: LeaguesViewProtocol, selectedSport: Sport) -> LeaguesPresenterProtocol {
        return LeaguesPresenter(
            view: view,
            selectedSport: selectedSport,
            networkService: self.networkService,
            localService: self.localService
        )
    }
    
    func makeTeamDetailsPresenter(view: TeamDetailsViewProtocol,
                                  teamData: Team,
                                  selectedSport: Sport) -> TeamDetailsPresenterProtocol {
        
        return TeamDetailsPresenter(
            view: view,
            teamData: teamData,
            selectedSport: selectedSport,
            networkService: self.networkService
        )
    }
}
