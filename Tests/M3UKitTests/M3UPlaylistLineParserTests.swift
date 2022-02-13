//
//  M3UPlaylistLineParserTests.swift
//  
//
//  Created by Александр Алгашев on 09.01.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistLineParserTests: XCTestCase {
    var sut: M3UPlaylistLineParser!

    override func setUpWithError() throws {
        self.sut = M3UPlaylistLineParser()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_parseEXTM3U_correctParsing() throws {
        let extM3U = "#EXTM3U"
        extM3U.forEach {
            _ = self.sut.feed($0)
        }
        self.sut.buildLine()
        
        XCTAssertEqual(self.sut.line, M3UPlaylistLine.extM3U)
    }
    
    func test_parseEXTINF_correctParsing() throws {
        let extInf = "#EXTINF:-1,Ultra HD Cinema 4K UHD"
        let expectedLine = M3UPlaylistLine.extInf(-1, "Ultra HD Cinema 4K UHD")
        extInf.forEach {
            _ = self.sut.feed($0)
        }
        self.sut.buildLine()
        
        XCTAssertEqual(self.sut.line, expectedLine)
    }
    
    func test_parseEXTGRP_correctParsing() throws {
        let extGrp = "#EXTGRP:Кино"
        let expectedLine = M3UPlaylistLine.extGrp("Кино")
        extGrp.forEach {
            _ = self.sut.feed($0)
        }
        self.sut.buildLine()
        
        XCTAssertEqual(self.sut.line, expectedLine)
    }
    
    func test_parseResource_correctParsing() throws {
        let resource = "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"
        let expectedLine = M3UPlaylistLine.resource(resource)
        resource.forEach {
            _ = self.sut.feed($0)
        }
        self.sut.buildLine()
        
        XCTAssertEqual(self.sut.line, expectedLine)
    }
    
    func test_parsePlaylist_correctParsing() throws {
        var lines = [M3UPlaylistLine]()
        String.M3UPlaylist.demo.appending("\n").forEach {
            if self.sut.feed($0) {
                return
            } else if let line = self.sut.line {
                lines.append(line)
                self.sut = M3UPlaylistLineParser()
            }
        }
        
        XCTAssertEqual(lines, M3UDemoPlaylist.linesExample)
    }


}
