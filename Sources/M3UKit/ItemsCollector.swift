//
//  ItemsCollector.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The collector of items.
 */
final class ItemsCollector: ItemsCollectorProtocol {
    /**
     The collected characters.
     */
    private(set) var characters = ""
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
    private(set) var items = [M3UItemRepresentable]()
    /**
     The current parsed item.
     */
    private var item: M3UItem?
    
    /**
     Append M3U drective to collect.
     - Parameter directive: M3U drective to collect.
     */
    func append(_ directive: M3UDirective) {
        switch directive {
        case .extM3U:
            let item = M3UHeader()
            self.items.append(item)
        case .extInf:
            self.saveItemIfAvailable()
            self.item = M3UItem()
        case .extGrp:
            break
        }
    }
    /**
     Save current item if any.
     */
    private func saveItemIfAvailable() {
        if let item = self.item {
            self.items.append(item)
        }
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
        self.item?[key] = self.characters.trimmingCharacters(in: .whitespaces)
        self.characters = ""
        if key == .resource {
            self.saveItemIfAvailable()
            self.item = nil
        }
    }
    /**
     Save the collected custom key-value pair of M3U item.
     */
    func saveValue() {
        self.item?[self.key] = self.value.trimmingCharacters(in: .whitespaces)
        self.reset()
    }
    /**
     Reset collected values to initial state.
     */
    func reset() {
        self.characters = ""
        self.key = ""
        self.value = ""
    }
    
    
}
