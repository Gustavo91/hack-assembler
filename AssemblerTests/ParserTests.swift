//
//  AssemblerTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class ParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_translateAssembly_writeRightBinaryCode() {
        // When
        let assemblyPath = getPathOf(fileName: "testAssembly")
        let binaryPath = getPathOf(fileName: "testBinary")
        let assembly = getContentOf(filePath: assemblyPath)
        let binary = getContentOf(filePath: binaryPath)
        
        // Given
        let myBinary = Parser.translate(assembly: assembly)
        
        // Then
        XCTAssertEqual(myBinary, binary, "The binary build is not right")
    }
    
    // MARK: Private
    
    private func getPathOf(fileName: String) -> String {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: fileName, ofType: "txt") else {
            XCTAssert(false, "The \(fileName) file doesn't exist")
            return ""
        }
        
        return path
    }
    
    private func getContentOf(filePath: String) -> String {
        let url = URL(fileURLWithPath: filePath)
        guard let fileContent = try? String(contentsOf: url).trimmingCharacters(in: .whitespacesAndNewlines) else {
            XCTAssert(false, "The \(url.lastPathComponent) file couldn't be read")
            return ""
        }
        
        return fileContent
    }
}
