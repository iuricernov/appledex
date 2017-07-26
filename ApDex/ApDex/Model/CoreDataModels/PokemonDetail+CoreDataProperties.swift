//
//  PokemonDetail+CoreDataProperties.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/26/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData


extension PokemonDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonDetail> {
        return NSFetchRequest<PokemonDetail>(entityName: "PokemonDetail")
    }

    @NSManaged public var pokemonID: Int64
    @NSManaged public var name: String?
    @NSManaged public var weight: Int64
    @NSManaged public var height: Int64
    @NSManaged public var baseXP: Int64
    @NSManaged public var imageURL: String?
    @NSManaged public var pokemonTypes: NSSet?

}

// MARK: Generated accessors for pokemonTypes
extension PokemonDetail {

    @objc(addPokemonTypesObject:)
    @NSManaged public func addToPokemonTypes(_ value: PokemonType)

    @objc(removePokemonTypesObject:)
    @NSManaged public func removeFromPokemonTypes(_ value: PokemonType)

    @objc(addPokemonTypes:)
    @NSManaged public func addToPokemonTypes(_ values: NSSet)

    @objc(removePokemonTypes:)
    @NSManaged public func removeFromPokemonTypes(_ values: NSSet)

}
