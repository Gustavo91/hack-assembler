//
//  Code.swift
//  Assembler
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

class CodeGenerator {
    
    // MARK: - Properties
    
    var romAddress: Int = 0
    var ramAddress: Int = 1024
    var symbolsTable: [String: Int] = [
        "SP"     : 0,
        "LCL"    : 1,
        "ARG"    : 2,
        "THIS"   : 3,
        "THAT"   : 4,
        "R0"     : 0,
        "R1"     : 1,
        "R2"     : 2,
        "R3"     : 3,
        "R4"     : 4,
        "R5"     : 5,
        "R6"     : 6,
        "R7"     : 7,
        "R8"     : 8,
        "R9"     : 9,
        "R10"    : 10,
        "R11"    : 11,
        "R12"    : 12,
        "R13"    : 13,
        "R14"    : 14,
        "R15"    : 15,
        "SCREEN" : 16384,
        "KBD"    : 24576
    ]
    
    // MARK: - Singleton
    
    static let shared = CodeGenerator()

    // MARK: - Binary Translation
    
    func getBinaryOf(jumpSymbol: String?) -> String {
        guard let symbol = jumpSymbol , let binary = jumpConvertionTable[symbol]  else {
            return "000"
        }
        return binary
    }
    
    func getBinaryOf(destSymbol: String?) -> String {
        guard let symbol = destSymbol , let binary = destConvertionTable[symbol]  else {
            return "000"
        }
        return binary
    }
    
    func getBinaryOf(compSymbol: String?) -> String? {
        guard let symbol = compSymbol , let binary = compConvertionTable[symbol]  else {
            return nil
        }
        return binary
    }
    
    func getBinaryOf(symbol: String?, commandType: CommandType) -> String? {
        guard let symbol = symbol else {
            return nil
        }
        
        var binary = ""
        if let number = Int(symbol), number < maxAddressLimit {
            binary = String(number, radix: 2, uppercase: false)
        } else if commandType == .aCommand {
            binary = String(symbolsTable[symbol]!, radix: 2, uppercase: false)
        } else if commandType == .lCommand {
            return binary
        }
        
        return pad(string: binary, toSize: 16, padChar: "0")
    }
    
    // MARK: - Helpers
    
    func pad(string: String, toSize: Int, padChar: String) -> String {
        var padded = string
        for _ in 0..<(toSize - string.count) {
            padded = padChar + padded
        }
        return padded
    }
    
    func reset() {
        romAddress = 0
        ramAddress = 1024
    }
    
    // MARK: - Private
    
    private let maxAddressLimit = 32768
    
    private let jumpConvertionTable = [
        "NULL": "000",
        "JGT" : "001",
        "JEQ" : "010",
        "JGE" : "011",
        "JLT" : "100",
        "JNE" : "101",
        "JLE" : "110",
        "JMP" : "111",
    ]
    
    private let destConvertionTable = [
        "NULL": "000",
        "A"   : "100",
        "M"   : "001",
        "D"   : "010",
        "AM"  : "101",
        "AD"  : "110",
        "MD"  : "011",
        "AMD" : "111",
    ]
    
    private let compConvertionTable = [
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
    
}
