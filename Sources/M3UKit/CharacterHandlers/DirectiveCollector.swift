//
//  DirectiveCollector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The collector of directive characters.
 */
struct DirectiveCollector: CharacterHandler {
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
            DirectiveHandler(collector: self.collector).handle()
            next = LineStartDetector(collector: self.collector)
        } else if char.isWhitespace {
            next = self.route()
        } else if char == ":" {
            self.collector.append(char)
            next = self.route()
        } else {
            self.collector.append(char)
        }
        
        return next
    }
    /**
     Route to the next character handler.
     - Returns: The next character handler to parse.
     */
    private func route() -> CharacterHandler {
        DirectiveHandler(collector: self.collector).route()
    }
    
    
}
