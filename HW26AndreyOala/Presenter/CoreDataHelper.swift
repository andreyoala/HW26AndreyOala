//
//  CoreDataHelper.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 18.08.2022.
//

import Foundation
import UIKit

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func updateProfile() {
        guard context.hasChanges
        else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData() -> [Person]? {
        do {
            return try self.context.fetch(Person.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func saveData(name: String?, date: Date?, gender: String?) {
        let person = Person(context: context)
        person.name = name
        person.dataPicker = date
        person.gender = gender
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(index: Int) {
        if let dataArray = fetchData() {
            context.delete(dataArray[index])
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

