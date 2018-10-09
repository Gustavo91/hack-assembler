//
//  CommandTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class CommandTests: XCTestCase {
    
    let aCommands = ["@JK", "@i", "@E"]
    let cCommands = ["D=M", "D=D-A", "A=D+1;JMP", "M=M-1", "0;JEQ"]
    let lCommands = ["(i)", "(Loop)", "(end1)"]
    let invalidCommands = [
        "@", "123@", ";12@34", "@123",
        "D=A+A", "", ";JMP", "M=", "D=A+A",
        "(7", "7)", ";7", "(7)", "()"
    ]

    func test_type_returnACommandType() {
        aCommands.forEach {
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.aCommand, "\($0) should be a A_command")
        }
    }
    
    func test_type_returnLCommandType() {
        lCommands.forEach {
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.lCommand, "\($0) should be a L_command")
        }
    }
    
    func test_type_returnCCommandType() {
        cCommands.forEach {
            let commandType = Command(command: $0).type
            XCTAssertEqual(commandType, CommandType.cCommand, "\($0) should be a C_command")
        }
    }
    
    func test_symbol_returnsForLCommands() {
        let validSymbols = lCommands.map { (command) -> (String) in
            var symbol = ""
            symbol = command.replacingOccurrences(of: "(", with: "")
            symbol = symbol.replacingOccurrences(of: ")", with: "")
            return symbol
        }
        
        for (index, command) in lCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.symbol, validSymbols[index])
        }
    }
    
    func test_symbol_returnsForACommands() {
        let validSymbols = aCommands.map { (command) -> (String) in
             return command.replacingOccurrences(of: "@", with: "")
        }
        
        for (index, command) in aCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.symbol, validSymbols[index])
        }
    }
    
    func test_dest_returnsForCCommands() {
        let validCommands = ["A=D+1;JMP", "AD=D+1;JEQ", "ADM=0;JNE"]
        let validStrings = ["A", "AD", "ADM"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.dest, validStrings[index])
        }
    }
    
    func test_dest_whenAbsentInCCommands_returnsEmptyString() {
        let command = Command(command: "D+1;JMP")
        XCTAssertEqual(command.dest, "NULL")
        
    }
    
    func test_comp_returnForCCommands() {
        let validCommands = ["A=D+1;JMP", "D+1;JEQ", "0", "M-1", "M=A-1"]
        let validStrings = ["D+1", "D+1", "0", "M-1", "A-1"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.comp, validStrings[index])
        }
    }
    
    func test_jump_returnForCCommands() {
        let validCommands = ["A=D+1;JMP", "D+1;JEQ", "0;JNE"]
        let validStrings = ["JMP", "JEQ", "JNE"]
        for (index, command) in validCommands.enumerated() {
            let command = Command(command: command)
            XCTAssertEqual(command.jump, validStrings[index])
        }
    }
    
    func test_jump_whenAbsentInCCommands_returnsEmptyString() {
        let command = Command(command: "D+1")
        XCTAssertEqual(command.jump, "NULL")
    }
    
}
