//
//  ItemsCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class ItemsCollectorTests: XCTestCase {
    private var sut: ItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.sut = ItemsCollector()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func test_appendDirective_extM3U_appendsM3UHeader() throws {
        self.sut.append(.extM3U)
        
        XCTAssertEqual(self.sut.items.count, 1)
        XCTAssertTrue(self.sut.items[0] is M3UHeader)
    }
    
    func test_appendDirective_extInf_setsItemAndSavesPreviousItemIfAny() throws {
        // Sets item
        self.sut.append(.extInf)
        // Saves previous item
        self.sut.append(.extInf)
        
        XCTAssertEqual(self.sut.items.count, 1)
        XCTAssertTrue(self.sut.items[0] is M3UItem)
    }
    
    func test_appendChar_appendsCharacter() throws {
        let char: Character = "a"
        self.sut.append(char)
        
        XCTAssertEqual(self.sut.characters.last, char)
    }
    
    func test_saveKey_savesKeyToItemIfAny() throws {
        let key = M3UItem.Key.title
        let value = "Value"
        value.forEach {
            self.sut.append($0)
        }
        // Sets item
        self.sut.append(.extInf)
        self.sut.save(key)
        // Saves previous item
        self.sut.append(.extInf)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveKey_trimsWitespaceBeforeSave() throws {
        let key = M3UItem.Key.title
        let value = "Value"
        (" " + value + " ").forEach {
            self.sut.append($0)
        }
        // Sets item
        self.sut.append(.extInf)
        self.sut.save(key)
        // Saves previous item
        self.sut.append(.extInf)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveKey_notSavesKeyIfNoItem() throws {
        let key = M3UItem.Key.title
        let value = "Value"
        value.forEach {
            self.sut.append($0)
        }
        self.sut.save(key)
        // Saves previous item
        self.sut.append(.extInf)
        
        XCTAssertEqual(self.sut.items.count, 0)
    }
    
    func test_saveKey_resource_savesItemIfAny() throws {
        let key = M3UItem.Key.resource
        let value = "Value"
        value.forEach {
            self.sut.append($0)
        }
        // Sets item
        self.sut.append(.extInf)
        self.sut.save(key)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveKey_resource_resetsCurrentItem() throws {
        let key = M3UItem.Key.resource
        let value = "Value"
        value.forEach {
            self.sut.append($0)
        }
        // Sets item
        self.sut.append(.extInf)
        self.sut.save(key)
        // Try to save previous item
        self.sut.append(.extInf)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveValue_savesCustomKeyOfItemIfAny() throws {
        let key = "Key"
        let value = "Value"
        self.sut.key = key
        self.sut.value = value
        
        // Sets item
        self.sut.append(.extInf)
        self.sut.saveValue()
        // Try to save previous item
        self.sut.append(.extInf)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveValue_trimsWitespaceBeforeSave() throws {
        let key = "Key"
        let value = "Value"
        self.sut.key = key
        self.sut.value = " " + value + " "
        
        // Sets item
        self.sut.append(.extInf)
        self.sut.saveValue()
        // Try to save previous item
        self.sut.append(.extInf)
        
        let item = self.sut.items[0] as! M3UItem
        
        XCTAssertEqual(item[key], value)
    }
    
    func test_saveValue_notSavesKeyIfNoItem() throws {
        let key = "Key"
        let value = "Value"
        self.sut.key = key
        self.sut.value = value
        
        self.sut.saveValue()
        // Try to save previous item
        self.sut.append(.extInf)
        
        XCTAssertEqual(self.sut.items.count, 0)
    }
    
    func test_saveValue_resetsCollector() throws {
        let key = "Key"
        let value = "Value"
        self.sut.key = key
        self.sut.value = value
        self.sut.append("a")
        
        self.sut.saveValue()
        
        XCTAssertTrue(self.sut.characters.isEmpty)
        XCTAssertTrue(self.sut.key.isEmpty)
        XCTAssertTrue(self.sut.value.isEmpty)
    }
    
    func test_reset_resetsCollector() throws {
        let key = "Key"
        let value = "Value"
        self.sut.key = key
        self.sut.value = value
        self.sut.append("a")
        
        self.sut.reset()
        
        XCTAssertTrue(self.sut.characters.isEmpty)
        XCTAssertTrue(self.sut.key.isEmpty)
        XCTAssertTrue(self.sut.value.isEmpty)
    }
    
    
    

}
