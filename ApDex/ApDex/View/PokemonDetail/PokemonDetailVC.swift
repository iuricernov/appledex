//
//  PokemonDetailVC.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/25/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation

class PokemonDetailVC : UIViewController, PokemonDetailPresenterDelegate {
    // Input variables:
    var selectedPokemonNumber: Int! = nil
    
    // Presenter:
    private var presenter: PokemonDetailPresenter! = nil
    
    // Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonBaseXPLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        presenter = PokemonDetailPresenter(forPokemonNumber: selectedPokemonNumber, withDelegate: self)
        presenter.delegateDidLoad()
    }
    
    // MARK: PokemonDetailPresenterDelegate
    
    func showLoadingPokemon() {
        activityIndicator.startAnimating()
    }
    
    func showPokemonData(forPokemonDetail pokemon: PokemonDetail) {
        pokemonNameLabel.text = pokemon.name
        pokemonNumberLabel.text = "Pokemon #\(pokemon.pokemonID)"
        pokemonWeightLabel.text = "Weight: \(pokemon.weight)"
        pokemonHeightLabel.text = "Height: \(pokemon.height)"
        pokemonBaseXPLabel.text = "Base experience: \(pokemon.baseXP)"
        
        let typeList = pokemon.pokemonTypes?.allObjects
            .map { $0 as! PokemonType }
            .filter { $0.name != nil }
            .map { $0.name!.capitalized }
            .joined(separator: ", ")
        
        if typeList != nil {
            pokemonTypeLabel.text = "Type: \(typeList!)"
        } else {
            pokemonTypeLabel.text = ""
        }
        activityIndicator.stopAnimating()
    }
    
    func showErrorLoadingPokemonData() {
        let alert = UIAlertController(title: "Error",
                                      message: "Something wrong happened while loading Pokemon number \(selectedPokemonNumber!)",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
        activityIndicator.stopAnimating()
    }
}
