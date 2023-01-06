//
//  CharacterHandler.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The protocol that the character handler must conform to.
 */
protocol CharacterHandler {
    /**
     The collector of the items that were parsed by character handlers.
     */
    var collector: ItemsCollectorProtocol { get }
    
    /**
     Feed character to handler to parse.
     - Parameter char: The character to parse.
     - Returns:Tthe character handler to parse next character.
     */
    func feed(_ char: Character) -> CharacterHandler?
    
    
}
