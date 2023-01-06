//
//  ExtInfRuntimeCollector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The collector of runtime value of `#EXTINF:` directive.
 */
struct ExtInfRuntimeCollector: CharacterHandler {
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
        if char.isNumber {
            self.collector.append(char)
        } else {
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
        let characters = self.collector.characters
        if char.isNewline {
            if characters == "-" {
                self.collector.save(.title)
            } else {
                self.collector.save(.runtime)
            }
            next = LineStartDetector(collector: self.collector)
        } else if characters == "-" {
            self.collector.append(char)
            next = ExtInfTitleCollector(collector: self.collector)
        } else {
            self.collector.save(.runtime)
            if !",;: ".contains(char) {
                self.collector.append(char)
            }
            next = ExtInfKeyStartDetector(collector: self.collector)
        }
        
        return next
    }
    
    
}
