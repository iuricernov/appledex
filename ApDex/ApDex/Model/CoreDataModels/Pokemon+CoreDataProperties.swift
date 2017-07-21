//
//  Pokemon+CoreDataProperties.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/21/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
