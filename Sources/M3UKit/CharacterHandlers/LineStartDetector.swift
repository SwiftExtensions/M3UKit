//
//  LineStartDetector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The detector of line start.
 */
struct LineStartDetector: CharacterHandler {
    /**
     The collector of the items that were parsed by character handlers.
     */
    let collector: ItemsCollectorProtocol
    
    /**
     Create instance of the detector of line start.
     - Parameter collector: The collector of the items that were parsed by character handlers.
     */
    init(collector: ItemsCollectorProtocol) {
        self.collector = collector
        self.collector.reset()
    }
    /**
     Feed character to handler to parse.
     - Parameter char: The character to parse.
     - Returns:Tthe character handler to parse next character.
     */
    func feed(_ char: Character) -> CharacterHandler? {
        if char.isNewline || char.isWhitespace { return nil }
        
        self.collector.append(char)
        
        return self.route(char)
    }
    /**
     Route to the next character handler according to the current character.
     - Parameter char: The character to detect next character handler.
     - Returns: The next character handler to parse.
     */
    private func route(_ char: Character) -> CharacterHandler {
        let next: CharacterHandler
        if char == "#" {
            next = DirectiveCollector(collector: self.collector)
        } else {
            next = ResourceCollector(collector: self.collector)
        }
        
        return next
    }
    
    
}
