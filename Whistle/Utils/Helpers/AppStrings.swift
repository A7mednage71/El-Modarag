//
//  AppStrings.swift
//  Whistle
//
//  Created by Ahmed Nageh on 05/06/2026.
//

import Foundation

struct AppStrings {
    
    struct Buttons {
        static var getStarted: String { "btn_get_started".localized }
        static var next:       String { "btn_next".localized }
        static var skip:       String { "btn_skip".localized }
        
        static var ok:         String { "btn_ok".localized }
        static var cancel:     String { "btn_cancel".localized }
        static var retry:      String { "btn_retry".localized }
        static var delete:     String { "btn_delete".localized }
    }
    
    struct Onboarding {
        static var title1: String { "onboarding_title_1".localized }
        static var desc1:  String { "onboarding_desc_1".localized }
        
        static var title2: String { "onboarding_title_2".localized }
        static var desc2:  String { "onboarding_desc_2".localized }
        
        static var title3: String { "onboarding_title_3".localized }
        static var desc3:  String { "onboarding_desc_3".localized }
    }
    
    struct Sports {
        static var title:    String { "sports_screen_title".localized }
        static var subtitle: String { "sports_screen_subtitle".localized }
        
        static var football:   String { "sport_football".localized }
        static var basketball: String { "sport_basketball".localized }
        static var cricket:    String { "sport_cricket".localized }
        static var tennis:     String { "sport_tennis".localized }
    }
    
    struct Favorites {
        static var title: String { "favorites_title".localized }
                
        struct EmptyState {
            static var title:   String { "fav_empty_title".localized }
            static var message: String { "fav_empty_message".localized }
        }
                
        struct Actions {
            static var deleteTitle: String { "fav_action_delete_title".localized }
            static var alertTitle:  String { "fav_alert_delete_title".localized }
            static var alertMsg:    String { "fav_alert_delete_msg".localized }
            static var confirmYes:  String { "fav_alert_confirm_yes".localized }
            static var confirmNo:   String { "fav_alert_confirm_no".localized }
        }
    }

    struct Leagues {
        static var title:    String { "leagues_header_title".localized }
        static var navError: String { "leagues_nav_error".localized }
    }
    
    struct LeagueDetails {
        static var upcomingEvents:     String { "ld_header_upcoming".localized }
        static var latestResults:      String { "ld_header_results".localized }
        static var participatingTeams: String { "ld_header_teams".localized }
        static var players:            String { "ld_header_players".localized }
            
        struct EmptyState {
            static var noUpcomingTitle:   String { "ld_empty_upcoming_title".localized }
            static var noUpcomingMessage: String { "ld_empty_upcoming_message".localized }
                
            static var noResultsTitle:    String { "ld_empty_results_title".localized }
            static var noResultsMessage:  String { "ld_empty_results_message".localized }
            
            static var noTeamsTitle:      String { "ld_empty_teams_title".localized }
            static var noPlayersTitle:    String { "ld_empty_players_title".localized }
            static var noTeamsMessage:    String { "ld_empty_teams_message".localized }
        }
    }
    
    struct TeamDetails {
        static var teamPlayersHeader: String { "td_header_players".localized }
        static var unknownPlayer:      String { "player_unknown".localized }
            
        static var redCards:    String { "td_stat_red".localized }
        static var yellowCards: String { "td_stat_yellow".localized }
        static var rating:      String { "td_stat_rating".localized }
            
        static func ageFormat(years: String) -> String {
            if LanguageManager.shared.currentLanguage == "ar" {
                return "\(years) سنة"
            } else {
                return "\(years) Yrs"
            }
        }
            
        struct Positions {
            static var coach:       String { "pos_coach".localized }
            static var goalkeepers: String { "pos_goalkeepers".localized }
            static var defenders:   String { "pos_defenders".localized }
            static var midfielders: String { "pos_midfielders".localized }
            static var forwards:    String { "pos_forwards".localized }
        }
        
        struct SquadEmptyState {
            static var title:   String { "td_squad_empty_title".localized }
            static var message: String { "td_squad_empty_message".localized }
        }
    }
    
    struct Settings {
        static var title:       String { "settings_title".localized }
        static var languageRow: String { "settings_row_language".localized }
            
        struct LanguageAlert {
            static var title:   String { "settings_lang_title".localized }
            static var message: String { "settings_lang_msg".localized }
        }
    }
        
    struct Alerts {
        static var errorTitle:       String { "alert_error_title".localized }
        static var defaultTitle:     String { "app_name".localized }
        static var playersNavError:  String { "error_players_unavailable".localized }
    }
}

// MARK: - In-App Localization Engine

extension String {
    var localized: String {
        let lang = LanguageManager.shared.currentLanguage
        
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
