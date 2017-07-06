//
//  CoreDataHelper.swift
//  Sleep Tracker
//
//  Created by Howard Wang on 7/5/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import Foundation

import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    
    static func returnNight() -> Night {
        return NSEntityDescription.insertNewObject(forEntityName: "Night", into: managedContext) as! Night
    }
    //is this automatically called when you close the app?
    static func saveCoreData() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func deleteNight(night: Night) {
        managedContext.delete(night)
        saveCoreData()
    }
    
    static func retrieveNights() -> [Night] {
        let fetchRequest = NSFetchRequest<Night>(entityName: "Night")
        var nights = [Night]()
        do {
            nights = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return nights
    }
    
    static func roundNightDuration(duration: Double) -> Double {
        return (duration * 10).rounded() / 10
    }
}


