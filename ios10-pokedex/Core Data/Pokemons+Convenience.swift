//
//  Pokemons+Convenience.swift
//  ios10-pokedex
//
//  Created by Austin Potts on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Pokemons {
    
    convenience init(name: String, id: Int, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.id = Int32(id)
        
    }
    
    
}
