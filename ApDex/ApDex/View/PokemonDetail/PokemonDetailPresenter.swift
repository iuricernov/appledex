//
//  PokemonDetailPresenter.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/26/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation

protocol PokemonDetailPresenterDelegate {
    func showLoadingPokemon()
    func showPokemonData(forPokemonDetail: PokemonDetail)
    func showErrorLoadingPokemonData()
}

class PokemonDetailPresenter : ADServicesManagerDelegate {
    private var pokemonNumber: Int!
    private var delegate: PokemonDetailPresenterDelegate!
    
    init(forPokemonNumber pokemonNumber: Int, withDelegate delegate: PokemonDetailPresenterDelegate) {
        self.pokemonNumber = pokemonNumber
        self.delegate = delegate
    }
    
    func delegateDidLoad() {
        delegate.showLoadingPokemon()
        ADServicesManager.sharedInstance.requestPokemonDetail(pokemonID: pokemonNumber, forDelegate: self)
    }
    
    // MARK: ADServicesManagerDelegate

    func requestCompletedWithSuccess(with object: [Any]?) {
        delegate.showPokemonData(forPokemonDetail: object!.first as! PokemonDetail)
    }
    
    func requestCompletedWithFailure(error: Error?) {
        delegate.showErrorLoadingPokemonData()
    }
}
