//
//  ADServicesManager.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/19/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import RestKit

protocol ADServicesManagerDelegate {
    func requestCompletedWithSuccess(with object: [Any]?)
    func requestCompletedWithFailure(error: Error?)
}

class ADServicesManager {
    private let baseURL = "http://pokeapi.co"
    private let objectManager: RKObjectManager
    
    private let allPokemonPathPattern = "/api/v2/pokemon/"
    private let pokemonDetailPathPattern = "/api/v2/pokemon/:pokemonID/"
    
    static let sharedInstance = ADServicesManager()
    
    init() {
        self.objectManager = RKObjectManager.init(baseURL: URL(string: baseURL))
        self.objectManager.requestSerializationMIMEType = RKMIMETypeJSON
        self.objectManager.managedObjectStore = RKManagedObjectStore.default()
        self.objectManager.router.routeSet.addRoutes(defaultClassRoutes())
        self.objectManager.addResponseDescriptors(from: defaultResponseDescriptors())
    }
    
    private func defaultClassRoutes() -> [RKRoute] {
        return [RKRoute(name: allPokemonPathPattern, pathPattern: allPokemonPathPattern, method: RKRequestMethod.GET),
                RKRoute(name: pokemonDetailPathPattern, pathPattern: pokemonDetailPathPattern, method: RKRequestMethod.GET)]
    }
    
    private func defaultResponseDescriptors() -> [RKResponseDescriptor] {
        let successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClass.successful)
        
        return [RKResponseDescriptor(mapping: PokemonRequestObject.responseMapping(),
                                     method: RKRequestMethod.GET,
                                     pathPattern: allPokemonPathPattern,
                                     keyPath: nil,
                                     statusCodes: successStatusCodes),
                RKResponseDescriptor(mapping: PokemonDetail.responseMapping(),
                                     method: RKRequestMethod.GET,
                                     pathPattern: pokemonDetailPathPattern,
                                     keyPath: nil,
                                     statusCodes: successStatusCodes)]
    }
    
    // MARK: Requests
    func requestAllPokemons(_ delegate: ADServicesManagerDelegate) {
        let parameters = ["limit": 151]
        let urlRequest: URLRequest! = objectManager.requestWithPath(
                                            forRouteNamed: allPokemonPathPattern,
                                            object: nil,
                                            parameters: parameters) as URLRequest!
        
        let operation: RKObjectRequestOperation! = objectManager.managedObjectRequestOperation(
                            with: urlRequest,
                            managedObjectContext: objectManager.managedObjectStore.mainQueueManagedObjectContext,
                            success:{(_: RKObjectRequestOperation?, result: RKMappingResult?) in
                                            delegate.requestCompletedWithSuccess(with: result?.array())
                                    },
                            failure:{(_: RKObjectRequestOperation?, error: Error?) in
                                            delegate.requestCompletedWithFailure(error: error)
                                    })
        
        objectManager.enqueue(operation)
    }
    
    func requestPokemonDetail(pokemonID: Int, forDelegate delegate: ADServicesManagerDelegate) {
        let urlPathData = ["pokemonID":pokemonID]
        let urlRequest: URLRequest! = objectManager.requestWithPath(
                                            forRouteNamed: pokemonDetailPathPattern,
                                            object: urlPathData,
                                            parameters: nil) as URLRequest!
        let operation: RKObjectRequestOperation! = objectManager.managedObjectRequestOperation(
            with: urlRequest,
            managedObjectContext: objectManager.managedObjectStore.mainQueueManagedObjectContext,
            success:{ (_: RKObjectRequestOperation?, result: RKMappingResult?) in
                            delegate.requestCompletedWithSuccess(with: result?.array())
                    },
            failure:{(_: RKObjectRequestOperation?, error: Error?) in
                            delegate.requestCompletedWithFailure(error: error)
                    })
        objectManager.enqueue(operation)
    }
}
