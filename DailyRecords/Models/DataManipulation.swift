//
//  DataManupulation.swift
//  DailyRecords
//
//  Created by Sora on 31.10.2022.
//

import Foundation
import CoreData

class DataManipulation {
    
    static var recordsList = [Record]()
        
    
    func saveData(context: NSManagedObjectContext) {
        do {
            try context.save()
        }catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadData(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        do {
            DataManipulation.recordsList = try context.fetch(request)
        }catch {
            print("Error loading data: \(error)")
        }
    }
    
    func deleteData(at index: Int, context: NSManagedObjectContext) {
        context.delete(DataManipulation.recordsList[index])
    }
    
    func saveCategories(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving categories: \(error)")
        }
    }
}
