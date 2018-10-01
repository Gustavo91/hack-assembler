//
//  AssemblerTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class ParserTests: XCTestCase {
    
    var sut: Parser!
    
    override func setUp() {
        super.setUp()
        sut = Parser()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}
