//
//  ExtInfValueStartDetector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The detector of value of custom key-value pair of `#EXTINF:` directive.
 */
struct ExtInfValueStartDetector: CharacterHandler {
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
        if char != " " {
            next = self.route(char)
        }
        
        return next
    }
    /**
     Route to the next character handler according to the current character.
     - Parameter char: The character to detect next character handler.
     - Returns: The next character handler to parse.
     */
    private func route(_ char: Character) -> CharacterHandler {
        var next: CharacterHandler
        if char.isNewline {
            self.collector.save(.title)
            next = LineStartDetector(collector: self.collector)
        } else {
            if char != "\"" {
                self.collector.value.append(char)
            }
            self.collector.append(char)
            next = ExtInfValueCollector(collector: self.collector)
        }
        
        return next
    }
    
    
}
