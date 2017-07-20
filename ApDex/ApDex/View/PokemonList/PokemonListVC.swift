//
//  PokemonListVC.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/18/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import UIKit

class PokemonListVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pokemonList: UITableView!
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 3;
            default:
                return 0;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell")!
        cell.textLabel?.text = PokemonListPresenter.getPokemon(at: indexPath)
        return cell
    }
}
