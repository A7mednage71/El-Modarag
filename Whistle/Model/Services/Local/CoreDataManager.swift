//
//  CoreDataManager.swift
//  Whistle
//
//  Created by Ahmed Nageh on 01/06/2026.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}
    
    var context : NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveFavoriteLeague(league:League) {
        
        let entity = LeagueEntity(context: context)
        entity.leagueKey = Int64(league.leagueKey ?? 0)
        entity.leagueName = league.leagueName
        entity.leagueLogo = league.leagueLogo
        entity.countryName = league.countryName
        
        do{
            try context.save()
        }
        catch{
            print("Error saving league: \(error.localizedDescription)")
        }
        
    }
    
    func fetchAllFavorites() -> [League] {
        let fetchRequest = LeagueEntity.fetchRequest()
        
        do{
            let entites = try context.fetch(fetchRequest)
            
            let leagues: [League] = entites.map{ entity in
                return League(
                    leagueKey: Int(entity.leagueKey),
                    leagueName: entity.leagueName,
                    leagueLogo: entity.leagueLogo,
                    countryName: entity.countryName)
                
            }
            
            return leagues
            
        }catch{
            print(" Error fetching favorites: \(error.localizedDescription)")
            return []
        }
        
    }
    
    func deleteFavoriteLeague(leagueKey: Int) {
        
        let fetchRequest =  LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
            
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
            print("League removed from favorites!")
        } catch {
            print("Error deleting league: \(error.localizedDescription)")
        }
    }
    
    func isLeagueFavorite(leagueKey: Int?) -> Bool {
        
        guard let key = leagueKey else { return false }
        let fetchRequest = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", key)
                    
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error Check league FAV Status: \(error.localizedDescription)")
            return false
        }
    }
    
}
