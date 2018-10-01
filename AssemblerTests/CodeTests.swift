//
//  CodeTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class CodeTests: XCTestCase {
    
    let jumpConvertionTable = [
        "JGT": "001",
        "JEQ": "010",
        "JGE": "011",
        "JLT": "100",
        "JNE": "101",
        "JLE": "110",
        "JMP": "111",
    ]
    
    let destConvertionTable = [
        "A": "100",
        "M": "001",
        "D": "010",
        "AM": "101",
        "AD": "110",
        "MD": "011",
        "AMD": "111",
    ]
    
    let compConvertionTable = [
        "0"   : "0101010",
        "1"   : "0111111",
        "-1"  : "0111010",
        "D"   : "0001100",
        "A"   : "0110000",
        "!D"  : "0001101",
        "!A"  : "0110001",
        "-D"  : "0001111",
        "-A"  : "0110011",
        "D+1" : "0011111",
        "A+1" : "0110111",
        "1+D" : "0011111",
        "1+A" : "0110111",
        "D-1" : "0001110",
        "A-1" : "0110010",
        "D+A" : "0000010",
        "A+D" : "0000010",
        "D-A" : "0010011",
        "A-D" : "0000111",
        "D&A" : "0000000",
        "D|A" : "0010101",
        "M"   : "1110000",
        "!M"  : "1110001",
        "-M"  : "1110011",
        "M+1" : "1110111",
        "1+M" : "1110111",
        "M-1" : "1110010",
        "D+M" : "1000010",
        "M+D" : "1000010",
        "D-M" : "1010011",
        "M-D" : "1000111",
        "D&M" : "1000000",
        "M&D" : "1000000",
        "D|M" : "1010101",
        "M|D" : "1010101",
    ]
    
    func test_jump_returnsRightBinaryCode() {
        jumpConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(Code.getBinaryOf(jumpSymbol: symbol), binary)
        }
        XCTAssertEqual(Code.getBinaryOf(jumpSymbol: nil), "000")
        XCTAssertEqual(Code.getBinaryOf(jumpSymbol: "Gustavo"), "000")
    }
    
    func test_dest_returnsRightBinaryCode() {
        destConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(Code.getBinaryOf(destSymbol: symbol), binary)
        }
        XCTAssertEqual(Code.getBinaryOf(destSymbol: nil), "000")
        XCTAssertEqual(Code.getBinaryOf(destSymbol: "Gustavo"), "000")
    }
    
    func test_comp_returnsRightBinaryCode() {
        compConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(Code.getBinaryOf(compSymbol: symbol), binary)
        }
        XCTAssertNil(Code.getBinaryOf(compSymbol: nil))
        XCTAssertNil(Code.getBinaryOf(compSymbol: "Gustavo"))
    }
    
}
