//
//  Parser.swift
//  Assembler
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

class Parser {
    
    static let codeGenerator = CodeGenerator.shared
    
    static func translate(assembly: String) -> String {
        let assemblyStatements = assembly.getLines()
        substituteLabelsForAddress(statements: assemblyStatements)
        substituteVariablesForAddress(statements: assemblyStatements)
        let binaryStatements: [String] = assemblyStatements.map {
            return getBinaryOf(string: String($0))
        }
        codeGenerator.reset()
        return binaryStatements.filter({$0 != ""}).joined(separator: "\n")
    }
    
    // MARK: - Private
    
    static private func substituteVariablesForAddress(statements: [String]) {
        statements.forEach {
            let command = Command(command: $0)
            
            if command.type == .aCommand {
                
                if codeGenerator.symbolsTable[command.symbol!] == nil {
                    codeGenerator.symbolsTable[command.symbol!] = codeGenerator.ramAddress
                    codeGenerator.ramAddress += 1
                }
                
            }
        }
    }
    
    static private func substituteLabelsForAddress(statements: [String]) {
        statements.forEach {
            let command = Command(command: $0)
            
            if command.type == .lCommand {
                
                if codeGenerator.symbolsTable[command.symbol!] == nil {
                    codeGenerator.symbolsTable[command.symbol!] = codeGenerator.romAddress
                }
                
            } else if command.type == .cCommand || command.type == .aCommand {
                codeGenerator.romAddress += 1
            }
        }
    }
    
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
            binary = codeGenerator.getBinaryOf(symbol: command.symbol, commandType: command.type)
        } else if command.type == .cCommand {
            binary = buildBinaryOfC(command: command)
        }
        
        return binary
    }
    
    static private func buildBinaryOfC(command: Command) -> String? {
        if let binaryComp = codeGenerator.getBinaryOf(compSymbol: command.comp) {
            let binaryDest = codeGenerator.getBinaryOf(destSymbol: command.dest)
            let binaryJump = codeGenerator.getBinaryOf(jumpSymbol: command.jump)
            let noPaddedBinary = binaryComp + binaryDest + binaryJump
            let paddedbinary = codeGenerator.pad(string: noPaddedBinary, toSize: 16, padChar: "1")
            return paddedbinary
        }
        
        return nil
    }
    
}



