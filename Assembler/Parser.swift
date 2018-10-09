//
//  Parser.swift
//  Assembler
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

class Parser {
    
    static func translate(assembly: String) -> String {
        let assemblyStatements = split(string: assembly, separator: "\r\n")
        let binaryStatements: [String] = assemblyStatements.map {
            return getBinaryOf(string: String($0))
        }
        
        return binaryStatements.joined(separator: "\n")
    }
    
    // MARK: - Private
    
    static private func getBinaryOf(string: String) -> String {
        let command = Command(command: string)
        let binary = getBinaryOf(command: command)
        
        guard let bin = binary else {
            // Handle error
            return ""
        }
        
        return bin
    }
    
    static private func split(string: String, separator: Character) -> [Substring] {
        let modifiedString = string
            .replacingOccurrences(of: " ", with: "")
            .split(separator: separator)
        
        return modifiedString
    }
    
    static private func getBinaryOf(command: Command) -> String? {
        var binary: String?
        if command.type == .aCommand || command.type == .lCommand {
            binary = Code.getBinaryOf(symbol: command.symbol)
        } else if command.type == .cCommand {
            binary = buildBinaryOfC(command: command)
        }
        
        return binary
    }
    
    static private func buildBinaryOfC(command: Command) -> String? {
        if let binaryComp = Code.getBinaryOf(compSymbol: command.comp) {
            let binaryDest = Code.getBinaryOf(destSymbol: command.dest)
            let binaryJump = Code.getBinaryOf(jumpSymbol: command.jump)
            let noPaddedBinary = binaryComp + binaryDest + binaryJump
            let paddedbinary = Code.pad(string: noPaddedBinary, toSize: 16, padChar: "1")
            return paddedbinary
        }
        
        return nil
    }
    
}



