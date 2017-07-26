//
//  PokemonType+CoreDataProperties.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/26/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData


extension PokemonType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonType> {
        return NSFetchRequest<PokemonType>(entityName: "PokemonType")
    }

    @NSManaged public var slot: Int64
    @NSManaged public var name: String?
    @NSManaged public var pokemonDetail: PokemonDetail?

}
