//
//  PokemonDetailVC.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/25/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation

class PokemonDetailVC : UIViewController {
    // Input variables:
    var selectedPokemonNumber: Int! = nil
    
    // Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonBaseXPLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        pokemonNumberLabel.text = String(selectedPokemonNumber)
    }
}
