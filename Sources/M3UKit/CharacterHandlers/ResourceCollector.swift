//
//  ResourceCollector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The collector of resource.
 */
struct ResourceCollector: CharacterHandler {
    /**
     The collector of the items that were parsed by character handlers.
     */
    let collector: ItemsCollectorProtocol
    
    /**
     Feed character to handler to parse.
     - Parameter char: The character to parse.
     - Returns:Tthe character handler to parse next character.
     */
    func feed(_ char: Character) -> CharacterHandler? {
        var next: CharacterHandler?
        if char.isNewline {
            self.collector.save(.resource)
            next = self.route()
        } else {
            self.collector.append(char)
        }
        
        return next
    }
    /**
     Handle route process to the next character handler.
     - Parameter char: The character to detect next character handler.
     - Returns: The next character handler to parse.
     */
    private func route() -> CharacterHandler {
       LineStartDetector(collector: self.collector)
    }
    
    
}
