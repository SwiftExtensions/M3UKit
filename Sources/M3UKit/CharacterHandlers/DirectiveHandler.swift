//
//  DirectiveHandler.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The handler of directive.
 */
struct DirectiveHandler {
    /**
     The collector of the items that were parsed by character handlers.
     */
    let collector: ItemsCollectorProtocol
    
    /**
     Route to the next character handler.
     - Returns: The next character handler to parse.
     */
    func route() -> CharacterHandler {
        let handler: CharacterHandler
        if let directive = self.handle() {
            handler = self.route(directive)
        } else {
            handler = CharactersCollector(collector: self.collector)
        }
        
        return handler
    }
    /**
     Handles M3U directive.
     - Returns: M3U directive if any.
     */
    @discardableResult
    func handle() -> M3UDirective? {
        let characters = self.collector.characters
        let directive = M3UDirective(rawValue: characters)
        if let directive {
            self.collector.append(directive)
        }
        self.collector.reset()
        
        return directive
    }
    /**
     Route to the next character handler.
     - Parameter directive: The M3U directive.
     - Returns: The next character handler to parse.
     */
    private func route(_ directive: M3UDirective) -> CharacterHandler {
        let handler: CharacterHandler
        switch directive {
        case .extM3U:
            handler = CharactersCollector(collector: self.collector)
        case .extInf:
            handler = ExtInfRuntimeSignDetector(collector: self.collector)
        case .extGrp:
            handler = ExtGrpCollector(collector: self.collector)
        }
        
        return handler
    }
    
    
}
