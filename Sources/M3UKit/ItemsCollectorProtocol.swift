//
//  ItemsCollectorProtocol.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The protocol to adopt by the collector of items.
 */
protocol ItemsCollectorProtocol: AnyObject {
    /**
     The collected characters.
     */
    var characters: String { get }
    /**
     The custom key of M3U item.
     */
    var key: String { get set }
    /**
     The value of the custom key of M3U item.
     */
    var value: String { get set }
    /**
     The items collection.
     */
    var items: [M3UItemRepresentable] { get }
    
    /**
     Append M3U drective to collect.
     - Parameter directive: M3U drective to collect.
     */
    func append(_ directive: M3UDirective)
    /**
     Append character to collect.
     - Parameter char: Character to collect.
     */
    func append(_ char: Character)
    /**
     Save the M3U item key-value pair.
     - Parameter key: The M3U item key to save.
     */
    func save(_ key: M3UItem.Key)
    /**
     Save the collected custom key-value pair of M3U item.
     */
    func saveValue()
    /**
     Reset collected values to initial state.
     */
    func reset()
    
    
}
