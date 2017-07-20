//
//  Pokemon+CoreDataClass.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/19/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData
import RestKit

public class PokemonRequestObject : NSObject {
    var results: [Pokemon] = []
    
    static func responseMapping() -> RKObjectMapping {
        let mapping = RKObjectMapping(for: PokemonRequestObject.self)!
        mapping.addRelationshipMapping(withSourceKeyPath: "results", mapping: Pokemon.responseMapping())
        return mapping
    }
}

@objc(Pokemon)
public class Pokemon: NSManagedObject {
    static func responseMapping() -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: mr_entityName(), in: RKManagedObjectStore.default())!
        mapping.addAttributeMappings(from: ["name"])
        return mapping
    }
}
