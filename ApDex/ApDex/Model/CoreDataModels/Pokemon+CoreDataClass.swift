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
    var number: Int? {
        get { return url != nil ? Pokemon.parseNumberFromURL(url!) : nil }
    }
    
    private static func parseNumberFromURL(_ urlString: String) -> Int? {
        if let url = URL(string: urlString) {
            return Int(url.lastPathComponent)
        } else {
            return nil
        }
    }
    
    static func responseMapping() -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: mr_entityName(), in: RKManagedObjectStore.default())!
        mapping.identificationAttributes = ["url"]
        mapping.addAttributeMappings(from: ["name", "url"])
        return mapping
    }
}
