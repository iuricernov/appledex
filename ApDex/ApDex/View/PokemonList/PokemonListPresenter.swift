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

    private var pokemonData: [(number: Int?, name: String)]? = nil

    init(_ delegate: PokemonListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func delegateDidLoad() {
        delegate!.presenterWillLoadPokemonList()
        ADServicesManager.sharedInstance.requestAllPokemons(self)
    }
    
    func getPokemonCount() -> Int {
        return pokemonData?.count ?? 0
    }
    
    func getPokemon(at indexPath: IndexPath) -> String {
        if indexPath.section == 0 && (pokemonData?.count ?? 0) > indexPath.row {
            let name = pokemonData![indexPath.row].name
            if let number = pokemonData![indexPath.row].number {
                return "\(number) - \(name)"
            } else {
                return name
            }
        } else {
            return ""
        }
    }
    
    // MARK: ADServicesManagerDelegate
    
    func requestCompletedWithSuccess(with object: [Any]?) {
        loadPokemonData()
        delegate!.presenterDidFinishLoadingPokemonListWithSuccess()
    }
    
    func requestCompletedWithFailure(error: Error?) {
        delegate!.presenterDidFinishLoadingPokemonListWithError()
    }
    
    // MARK: Helpers
    func loadPokemonData() {
        if let allPokemon = Pokemon.mr_findAll() as! [Pokemon]? {
            var pokemonFromRequest : [(Int?,String)] = []
            for pokemon in allPokemon {
                pokemonFromRequest.append((number: pokemon.number, name: pokemon.name ?? ""))
            }
            pokemonData = pokemonFromRequest.sorted(by: {
                return ($0.0 ?? Int.max) <= ($1.0 ?? Int.max)
            })
        }
    }
}
