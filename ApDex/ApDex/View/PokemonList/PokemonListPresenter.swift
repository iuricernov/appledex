//
//  PokemonListPresenter.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/18/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import CoreData

protocol PokemonListPresenterDelegate: class {
    func presenterWillLoadPokemonList()
    func presenterDidFinishLoadingPokemonListWithSuccess()
    func presenterDidFinishLoadingPokemonListWithError()
}

class PokemonListPresenter : ADServicesManagerDelegate {
    private weak var delegate: PokemonListPresenterDelegate? = nil

    private var fetchedResultsController: NSFetchedResultsController<Pokemon>? = nil

    init(_ delegate: PokemonListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func delegateDidLoad() {
        delegate!.presenterWillLoadPokemonList()
        ADServicesManager.sharedInstance.requestAllPokemons(self)
    }
    
    func getPokemonCount() -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func getPokemon(at indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return fetchedResultsController?.object(at: indexPath).name ?? ""
        } else {
            return "";
        }
    }
    
    // MARK: ADServicesManagerDelegate
    
    func requestCompletedWithSuccess(with object: [Any]?) {
        let fetchRequest:NSFetchRequest<Pokemon> = Pokemon.mr_requestAllSorted(by: "name", ascending: true) as! NSFetchRequest<Pokemon>
        fetchedResultsController = NSFetchedResultsController.init(fetchRequest: fetchRequest,
                                                                   managedObjectContext: NSManagedObjectContext.mr_default(),
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        do {
            try fetchedResultsController?.performFetch()
            delegate!.presenterDidFinishLoadingPokemonListWithSuccess()
        } catch {
            delegate!.presenterDidFinishLoadingPokemonListWithError()
        }
    }
    
    func requestCompletedWithFailure(error: Error?) {
        delegate?.presenterDidFinishLoadingPokemonListWithError()
    }
}
