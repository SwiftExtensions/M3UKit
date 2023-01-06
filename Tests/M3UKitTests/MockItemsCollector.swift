//
//  MockItemsCollector.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 04.01.2023.
//

@testable import M3UKit

/**
 The mock collector of items.
 */
final class MockItemsCollector: ItemsCollectorProtocol {
    /**
     The collected characters.
     */
    var characters = ""
    /**
     The custom key of M3U item.
     */
    var key = ""
    /**
     The value of the custom key of M3U item.
     */
    var value = ""
    /**
     The items collection.
     */
    var items = [M3UItemRepresentable]()
    /**
     Appended M3U directives.
     */
    private(set) var directives = [M3UDirective]()
    /**
     Saved M3U item keys.
     */
    private(set) var keys = [M3UItem.Key]()
    /**
     Saved values of M3U item custom key-value pairs.
     */
    private(set) var values = [String]()
    /**
     The number of called resets.
     */
    private(set) var resets = 0
    
    /**
     Append M3U drective to collect.
     - Parameter directive: M3U drective to collect.
     */
    func append(_ directive: M3UDirective) {
        self.directives.append(directive)
    }
    /**
     Append character to collect.
     - Parameter char: Character to collect.
     */
    func append(_ char: Character) {
        self.characters.append(char)
    }
    /**
     Save the M3U item key-value pair.
     - Parameter key: The M3U item key to save.
     */
    func save(_ key: M3UItem.Key) {
        self.keys.append(key)
    }
    /**
     Save the collected custom key-value pair of M3U item.
     */
    func saveValue() {
        self.values.append(self.value)
    }
    /**
     Reset collected values to initial state.
     */
    func reset() {
        self.resets += 1
    }
    
    
}
