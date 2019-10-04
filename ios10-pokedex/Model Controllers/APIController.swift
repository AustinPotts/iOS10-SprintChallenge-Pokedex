//
//  APIController.swift
//  ios10-pokedex
//
//  Created by Austin Potts on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class APIController {
    
    //Holder to append pokemon
    var pokemonCollection: [Pokemon] = []
    
    
    //Create the base URL from which the JSON will be parsed
    let baseURL = URL(string: "https://pokeapi.co//api/v2/pokemon/")!
    
    
    //Create a function that will take in the search term & a result of Pokemon to decode if no Error
    func getPokemon(searchTerm: String, completion: @escaping(Result<Pokemon, Error>)-> Void ){
        
        //Append the search Term to the base url. Lowercased or else will not parse API correctly
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        //Open up the URLSession to connect to API
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            //Handle your errors
            if let error = error {
                NSLog("Error with data task: \(error)")
                completion(.failure(error))
                return
            }
            
            //Make sure you have the data
            guard let data = data  else {
                NSLog("No data located")
                completion(.failure(NSError()))
                return
            }
            
            
        //Do, Try, Catch to Deocode the Data from JSON & Catch any errors
            do {
                let decoder = JSONDecoder()
         //Converting any snake case JSON without enum
                decoder.keyDecodingStrategy = .convertFromSnakeCase
              let pokemonSearch = try decoder.decode(Pokemon.self, from: data)
        //Printing the pokemon searched to test success
                print(pokemonSearch)
                completion(.success(pokemonSearch))
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    //This function will append the pokemon to the array storage [Pokemon]
    func addSomePokemon(pokemon: Pokemon){
        pokemonCollection.append(pokemon)
    }
    
    
    
}
