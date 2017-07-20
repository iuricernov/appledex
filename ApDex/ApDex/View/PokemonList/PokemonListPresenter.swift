//
//  PokemonListPresenter.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/18/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation

class PokemonListPresenter {
    static func getPokemon(at indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return "4 - Charmander"
            case 1:
                return "5 - Charmeleon"
            case 2:
                return "6 - Charizard"
            default:
                return ""
            }
        } else {
            return "";
        }
    }
}
