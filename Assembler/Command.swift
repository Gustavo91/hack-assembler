//
//  Command.swift
//  Assembler
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

enum CommandType {
    case aCommand
    case lCommand
    case cCommand
    case none
}

struct Command {
    
    // MARK: - Properties
    
    var command: String
    var type: CommandType { return getCommandType() }
    var symbol: String? { return type == .aCommand || type == .lCommand ? command.getMatch(pattern: symbolPattern) : nil}
    var dest: String? { return type == .cCommand ? command.getMatch(pattern: cCommandPattern, group: 1) : nil }
    var comp: String? { return type == .cCommand ? command.getMatch(pattern: cCommandPattern, group: 2) : nil }
    var jump: String? { return type == .cCommand ? command.getMatch(pattern: cCommandPattern, group: 3) : nil }
    
    // MARK: - Init
    
    init(command: String) {
        self.command = command
    }
    
    // MARK: - Private
    
    private var aCommandPattern: String {return "^@\(symbolPattern)$"}
    private var lCommandPattern: String {return "^\\(\(symbolPattern)\\)$"}
    private var cCommandPattern: String {return "^(?:(.+)=)*([^.;]+?)(?:;(.+))*$"}
    private let symbolPattern = "((?:[A-Za-z$:_][\\w$:_]*)|\\d+)"
    
    private func getCommandType() -> CommandType {
        if isA() {
            return .aCommand
        } else if isL() {
            return .lCommand
        } else if isC() {
            return .cCommand
        }
        
        return .none
    }
    
    private func isA() -> Bool {
        let regex = try? NSRegularExpression(pattern: aCommandPattern)
        return command.hasMatch(regex: regex)
    }
    
    private func isL() -> Bool {
        let regex = try? NSRegularExpression(pattern: lCommandPattern)
        return command.hasMatch(regex: regex)
    }
    
    private func isC() -> Bool {
        let regex = try? NSRegularExpression(pattern: cCommandPattern)
        return command.hasMatch(regex: regex)
    }
    
}

