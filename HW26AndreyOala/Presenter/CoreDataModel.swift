//
//  CoreDataModel.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 18.08.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel {
    
    var people = [Person]()
    
    let coreDataHelper = CoreDataHelper()
    
    func updateProfile() {
        coreDataHelper.updateProfile()
    }
    
    func fetchData() {
        people = coreDataHelper.fetchData() ?? [Person]()
    }
    
    func saveData(name: String?, date: Date?, gender: String?) {
        coreDataHelper.saveData(name: name, date: date, gender: gender)
    }
    
    func deleteData(index: Int) {
        coreDataHelper.deleteData(index: index)
    }
}
