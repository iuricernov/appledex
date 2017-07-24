//
//  PokemonListVC.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/18/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PokemonListVC : UIViewController, UITableViewDelegate, UITableViewDataSource, PokemonListPresenterDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pokemonList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var presenter: PokemonListPresenter? = nil
    
    override func viewDidLoad() {
        presenter = PokemonListPresenter(self)
        presenter!.delegateDidLoad()
    }
    
    // MARK: PokemonListPresenterDelegate
    
    func presenterWillLoadPokemonList() {
        pokemonList.isUserInteractionEnabled = false
        pokemonList.alpha = 0.3
        activityIndicator.startAnimating()
    }

    func presenterDidFinishLoadingPokemonListWithSuccess() {
        pokemonList.reloadData()
        activityIndicator.stopAnimating()
        pokemonList.isUserInteractionEnabled = true
        pokemonList.alpha = 1
    }
    
    func presenterDidFinishLoadingPokemonListWithError() {
        let alert = UIAlertController(title: "Error",
                          message: "Something wrong happened while loading Pokemon list",
                          preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
        activityIndicator.stopAnimating()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return presenter!.getPokemonCount()
            default:
                return 0;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell")!
        cell.textLabel?.text = presenter!.getPokemon(at: indexPath)
        
        return cell
    }
}
