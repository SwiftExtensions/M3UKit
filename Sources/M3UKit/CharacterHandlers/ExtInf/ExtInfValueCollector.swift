//
//  ExtInfValueCollector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The collector of value of custom key-value pair of `#EXTINF:` directive.
 */
struct ExtInfValueCollector: CharacterHandler {
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
        if char == "\"" || char.isNewline {
            self.collector.saveValue()
            next = self.route(char)
        } else {
            self.collector.value.append(char)
            self.collector.append(char)
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
            next = LineStartDetector(collector: self.collector)
        } else {
            next = ExtInfKeyStartDetector(collector: self.collector)
        }
        
        return next
    }
    
    
}
