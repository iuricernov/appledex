//
//  PokemonType+CoreDataClass.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/26/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData

@objc(PokemonType)
public class PokemonType: NSManagedObject {
    static func responseMapping() -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: mr_entityName(), in: RKManagedObjectStore.default())!
        mapping.identificationAttributes = ["name"]
        mapping.addAttributeMappings(from: ["type.name":"name",
                                            "slot":"slot"])
        return mapping
    }
}
