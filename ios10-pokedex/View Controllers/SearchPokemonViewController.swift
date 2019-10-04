//
//  SearchPokemonViewController.swift
//  ios10-pokedex
//
//  Created by Austin Potts on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    
    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideViews()
    }
    
    
    
    
    // Create an update views function that updates the UI with the Data, if data is fetched correctly
    func updateViews() {
        guard isViewLoaded else {return}
        guard let pokemon = pokemon else {return}
        saveButton.isEnabled = true
        pokemonNameLabel.isHidden = false
        idLabel.isHidden = false
        typeLabel.isHidden = false
        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        pokemonSpriteImage.image = UIImage(data: pokemonImageData)
        pokemonNameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("Type: \(type.type.name.capitalized)")
            
        }
        
        typeLabel.text = types
        
    }
    
    //Create a function that hides the labels upon intial view
    func hideViews() {
        saveButton.isEnabled = false
        pokemonNameLabel.isHidden = true
        idLabel.isHidden = true
        typeLabel.isHidden = true
    }
    
    
   
    
    //Create a function from the Search Bar delegate. Make sure you have the search term text. Call the API Controller method that Gets the Pokemon Data. Make sure you have the searched Pokemon with a try? model.get(). Call your main queue & make the pokemon model equal the pokemon just searched
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        apiController?.getPokemon(searchTerm: searchTerm) { (pokemon) in
            guard let searchedForPokemon = try? pokemon.get() else {return}
            DispatchQueue.main.async {
                self.pokemon = searchedForPokemon
            }
        }
    }
    
    //In the save button, make sure you have the pokemon data. Then call the API Controller Method for adding pokemon
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemonSaved = pokemon else {return}
        //Create a function in your API Controller that adds the pokemon to your Array Var
        apiController?.addSomePokemon(pokemon: pokemonSaved)
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}
