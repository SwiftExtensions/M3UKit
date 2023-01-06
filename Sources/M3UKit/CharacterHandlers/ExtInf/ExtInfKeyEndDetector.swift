//
//  ExtInfKeyEndDetector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 05.01.2023.
//

/**
 The collector of custom M3U key of `#EXTINF:` directive.
 */
struct ExtInfKeyEndDetector: CharacterHandler {
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
        if char == " " {
            self.collector.append(char)
        } else {
            next = self.route(char)
        }
        
        return next
    }
    /**
     Feed character to handler to parse.
     - Parameter char: The character to parse.
     - Returns:Tthe character handler to parse next character.
     */
    private func route(_ char: Character) -> CharacterHandler {
        var next: CharacterHandler
        let characters = self.collector.characters
        if char == "=" {
            self.collector.key = characters.trimmingCharacters(in: .whitespaces)
            self.collector.append(char)
            next = ExtInfValueStartDetector(collector: self.collector)
        } else if char.isNewline {
            self.collector.save(.title)
            next = LineStartDetector(collector: self.collector)
        } else {
            self.collector.append(char)
            next = ExtInfTitleCollector(collector: self.collector)
        }
        
        return next
    }
    
    
}
