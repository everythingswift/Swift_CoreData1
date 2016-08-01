//
//  Grade+CoreDataProperties.swift
//  SwiftCD
//
//  Created by Sridhar Sanapala on 7/30/16.
//  Copyright © 2016 everythingswift. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Grade {

    @NSManaged var name: String?
    @NSManaged var students: NSSet?

}
