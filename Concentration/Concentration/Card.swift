//
//  File.swift
//  Concentration
//
//  Created by Jaime Lovera on 12/10/18.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier:  Int
    
    static  var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
