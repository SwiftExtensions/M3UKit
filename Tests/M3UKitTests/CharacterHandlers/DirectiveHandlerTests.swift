//
//  DirectiveHandlerTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 03.01.2023.
//

import XCTest
@testable import M3UKit

final class DirectiveHandlerTests: XCTestCase {
    private var sut: DirectiveHandler!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = DirectiveHandler(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func testRoute_invalidDirective_returnsCharactersCollector() throws {
        let handler = self.sut.route()
        
        XCTAssertTrue(handler is CharactersCollector)
        XCTAssertTrue(self.sut.collector === handler.collector)
    }
    
    func testRoute_invalidDirective_resetsCollector() throws {
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.resets, 1)
    }
    
    func testRoute_extM3UDirective_returnsCharactersCollector() throws {
        self.collector.characters = M3UDirective.extM3U.rawValue
        let handler = self.sut.route()
        
        XCTAssertTrue(handler is CharactersCollector)
        XCTAssertTrue(self.sut.collector === handler.collector)
    }
    
    func testRoute_extM3UDirective_appendsDirective() throws {
        let directive = M3UDirective.extM3U
        self.collector.characters = directive.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }
    
    func testRoute_extM3UDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extM3U.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.resets, 1)
    }
    
    func testRoute_extInfDirective_returnsExtInfRuntimeSignDetector() throws {
        self.collector.characters = M3UDirective.extInf.rawValue
        let handler = self.sut.route()
        
        XCTAssertTrue(handler is ExtInfRuntimeSignDetector)
        XCTAssertTrue(self.sut.collector === handler.collector)
    }
    
    func testRoute_extInfDirective_appendsDirective() throws {
        let directive = M3UDirective.extInf
        self.collector.characters = directive.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }
    
    func testRoute_extInfDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extInf.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.resets, 1)
    }
    
    func testRoute_extGrpDirective_returnsExtGrpCollector() throws {
        self.collector.characters = M3UDirective.extGrp.rawValue
        let handler = self.sut.route()
        
        XCTAssertTrue(handler is ExtGrpCollector)
        XCTAssertTrue(self.sut.collector === handler.collector)
    }
    
    func testRoute_extGrpDirective_appendsDirective() throws {
        let directive = M3UDirective.extGrp
        self.collector.characters = directive.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }
    
    func testRoute_extGrpDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extGrp.rawValue
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.resets, 1)
    }
    
    func testHandle_invalidDirective_returnsNil() throws {
        let directive = self.sut.handle()
        
        XCTAssertNil(directive)
    }
    
    func testHandle_invalidDirective_resetsCollector() throws {
        _ = self.sut.route()
        
        XCTAssertEqual(self.collector.resets, 1)
    }
    
    func testHandle_extM3UDirective_returnsExtM3U() throws {
        self.collector.characters = M3UDirective.extM3U.rawValue
        let directive = self.sut.handle()
        
        XCTAssertEqual(directive, .extM3U)
    }
    
    func testHandle_extM3UDirective_appendsDirective() throws {
        let directive = M3UDirective.extM3U
        self.collector.characters = directive.rawValue
        _ = self.sut.handle()

        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }

    func testHandle_extM3UDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extM3U.rawValue
        _ = self.sut.handle()

        XCTAssertEqual(self.collector.resets, 1)
    }

    func testHandle_extInfDirective_returnsExtInfRuntimeSignDetector() throws {
        self.collector.characters = M3UDirective.extInf.rawValue
        let directive = self.sut.handle()

        XCTAssertEqual(directive, .extInf)
    }

    func testHandle_extInfDirective_appendsDirective() throws {
        let directive = M3UDirective.extInf
        self.collector.characters = directive.rawValue
        _ = self.sut.handle()

        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }

    func testHandle_extInfDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extInf.rawValue
        _ = self.sut.handle()

        XCTAssertEqual(self.collector.resets, 1)
    }

    func testHandle_extGrpDirective_returnsExtGrpCollector() throws {
        self.collector.characters = M3UDirective.extGrp.rawValue
        let directive = self.sut.handle()

        XCTAssertEqual(directive, .extGrp)
    }

    func testHandle_extGrpDirective_appendsDirective() throws {
        let directive = M3UDirective.extGrp
        self.collector.characters = directive.rawValue
        _ = self.sut.handle()

        XCTAssertEqual(self.collector.directives.count, 1)
        XCTAssertEqual(self.collector.directives[0], directive)
    }

    func testHandle_extGrpDirective_resetsCollector() throws {
        self.collector.characters = M3UDirective.extGrp.rawValue
        _ = self.sut.route()

        XCTAssertEqual(self.collector.resets, 1)
    }
    

}
