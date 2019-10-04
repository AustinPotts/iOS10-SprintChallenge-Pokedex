//
//  DetailsPokemonViewController.swift
//  ios10-pokedex
//
//  Created by Austin Potts on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class DetailsPokemonViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    
    
    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    
    
    //Create an Update Views function that will update the views UI with the Data, if Json Data is parsed correctly
    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else{return}
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        pokemonImage.image = UIImage(data: pokemonImageData)
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        title = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("Type: \(type.type.name.capitalized)")
            
        }
        
        pokemonTypeLabel.text = types
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
