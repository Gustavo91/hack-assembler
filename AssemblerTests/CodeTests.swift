//
//  CodeTests.swift
//  AssemblerTests
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class CodeTests: XCTestCase {
    
    var sut = CodeGenerator.shared
    
    let jumpConvertionTable = [
        "NULL": "000",
        "JGT" : "001",
        "JEQ" : "010",
        "JGE" : "011",
        "JLT" : "100",
        "JNE" : "101",
        "JLE" : "110",
        "JMP" : "111",
    ]
    
    let destConvertionTable = [
        "NULL": "000",
        "A"   : "100",
        "M"   : "001",
        "D"   : "010",
        "AM"  : "101",
        "AD"  : "110",
        "MD"  : "011",
        "AMD" : "111",
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
    
    func test_getBinaryOfjumpSymbol_returnsRightBinaryCode() {
        jumpConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(sut.getBinaryOf(jumpSymbol: symbol), binary)
        }
        XCTAssertEqual(sut.getBinaryOf(jumpSymbol: nil), "000")
        XCTAssertEqual(sut.getBinaryOf(jumpSymbol: "Gustavo"), "000")
    }
    
    func test_getBinaryOfdestSymbol_returnsRightBinaryCode() {
        destConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(sut.getBinaryOf(destSymbol: symbol), binary)
        }
        XCTAssertEqual(sut.getBinaryOf(destSymbol: nil), "000")
        XCTAssertEqual(sut.getBinaryOf(destSymbol: "Gustavo"), "000")
    }
    
    func test_updateSymbolsTable_updatesTableWithAssemblySymbols() {
        
    }
    
    func test_getBinaryOfcompSymbol_returnsRightBinaryCode() {
        compConvertionTable.forEach { (symbol, binary) in
            XCTAssertEqual(sut.getBinaryOf(compSymbol: symbol), binary)
        }
        XCTAssertNil(sut.getBinaryOf(compSymbol: nil))
        XCTAssertNil(sut.getBinaryOf(compSymbol: "Gustavo"))
    }
    
    func test_getBinaryOfSymbol_returnsRightBinaryCode() {
        stride(from: 0, to: 32768, by: 5000).forEach {
            let binary = String($0, radix: 2, uppercase: false)
            let paddedBinary = sut.pad(string: binary, toSize: 16, padChar: "0")
            XCTAssertEqual(sut.getBinaryOf(symbol: String($0), commandType: CommandType.lCommand), paddedBinary)
        }
        XCTAssertNil(sut.getBinaryOf(compSymbol: nil))
        XCTAssertNil(sut.getBinaryOf(compSymbol: "Gustavo"))
        XCTAssertNil(sut.getBinaryOf(compSymbol: "32768"))
    }
        
}
