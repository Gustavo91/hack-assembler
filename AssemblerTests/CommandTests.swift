//
//  CommandTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class CommandTests: XCTestCase {
    
    let validACommands = ["@JK", "@i", "@E"]
    let validCCommands = ["D=M", "D=D-A", "A=D+1;JMP", "M=M-1", "0;JEQ"]
    let validLCommands = ["(i)", "(Loop)", "(end1)"]
    let invalidCommands = [
        "@", "123@", ";12@34", "@123",
        "D=A+A", "", ";JMP", "M=", "D=A+A",
        "(7", "7)", ";7", "(7)", "()"
    ]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_type_returnRightTypeForValidACommands() {
        validACommands.forEach{
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.aCommand, "\($0) should be a valid A_command")
        }
    }
    
    func test_type_returnRightTypeForValidCCommands() {
        validCCommands.forEach{
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.cCommand, "\($0) should be a valid C_command")
        }
    }
    
    func test_type_returnRightTypeForValidLCommands() {
        validLCommands.forEach{
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.lCommand, "\($0) should be a valid L_command")
        }
    }
    
    func test_type_returnRightTypeForInvalidLCommands() {
        invalidCommands.forEach{
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.none, "\($0) should be an invalidCommand")
        }
    }
    
    func test_symbol_returnRightStringForValidLCommands() {
        let validSymbols = validLCommands.map { (command) -> (String) in
            var symbol = ""
            symbol = command.replacingOccurrences(of: "(", with: "")
            symbol = symbol.replacingOccurrences(of: ")", with: "")
            return symbol
        }
        
        for (index, command) in validLCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.symbol, validSymbols[index])
        }
    }
    
    func test_symbol_returnRightStringForValidACommands() {
        let validSymbols = validACommands.map { (command) -> (String) in
             return command.replacingOccurrences(of: "@", with: "")
        }
        
        for (index, command) in validACommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.symbol, validSymbols[index])
        }
    }
    
    func test_dest_returnRightStringForValidCCommands() {
        let validCommands = ["A=D+1;JMP", "AD=D+1;JEQ", "ADM=0;JNE"]
        let validStrings = ["A", "AD", "ADM"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.dest, validStrings[index])
        }
    }
    
    func test_jump_returnRightStringForValidCCommands() {
        let validCommands = ["A=D+1;JMP", "D+1;JEQ", "0;JNE"]
        let validStrings = ["JMP", "JEQ", "JNE"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.jump, validStrings[index])
        }
    }
    
    func test_comp_returnRightStringForValidCCommands() {
        let validCommands = ["A=D+1;JMP", "D+1;JEQ", "0", "M-1", "M=A-1"]
        let validStrings = ["D+1", "D+1", "0", "M-1", "A-1"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.comp, validStrings[index])
        }
    }
    
}
