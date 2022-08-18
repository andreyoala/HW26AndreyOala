//
//  UserDataModel+CoreDataProperties.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 17.08.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var dataPicker: Date?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var textFieldName: String?

}

extension Person : Identifiable {

}
