//
//  Pokemon+CoreDataProperties.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/19/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var number: Int16
    @NSManaged public var name: String?

}
