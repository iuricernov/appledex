//
//  PokemonDetail+CoreDataClass.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/26/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData

@objc(PokemonDetail)
public class PokemonDetail: NSManagedObject {
    static func responseMapping() -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: mr_entityName(), in: RKManagedObjectStore.default())!
        mapping.identificationAttributes = ["pokemonID"]
        mapping.addAttributeMappings(from: ["id":"pokemonID",
                                            "name":"name",
                                            "weight":"weight",
                                            "height":"height",
                                            "base_experience":"baseXP",
                                            "sprites.front_default":"imageURL"])
        
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "types",
                                                         toKeyPath: "pokemonTypes",
                                                         with: PokemonType.responseMapping()))
        return mapping
    }
}
