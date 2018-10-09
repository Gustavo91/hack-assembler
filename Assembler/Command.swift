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
}

struct Command {
    
    // MARK: - Properties
    
    var command: String
    var type: CommandType { return getCommandType() }
    var symbol: String? { return type == .aCommand || type == .lCommand  ? getMatch(pattern: symbolPattern) : nil}
    var dest: String? { return type == .cCommand ? getMatch(pattern: cCommandPattern, group: 1) : nil }
    var comp: String? { return type == .cCommand ? getMatch(pattern: cCommandPattern, group: 2) : nil }
    var jump: String? { return type == .cCommand ? getMatch(pattern: cCommandPattern, group: 3) : nil }
    
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
        }
        
        return .cCommand
    }
    
    private func getMatch(pattern: String, group: Int = 0) -> String? {
        let range = NSMakeRange(0, command.count)
        guard let regex = try? NSRegularExpression(pattern: pattern),
            let match = regex.firstMatch(in: command, options: .reportProgress, range: range) else {
                return nil
        }
        
        let matchRange = group == 0 ? match.range : match.range(at: group)
        let nsStringcommand = command as NSString
        
        if matchRange.length == 0 {
            return "NULL"
        }
        let stringMatched = nsStringcommand.substring(with: matchRange)
        return stringMatched
    }
    
    private func isA() -> Bool {
        let regex = try? NSRegularExpression(pattern: aCommandPattern)
        return isMatch(regex: regex, string: command)
    }
    
    private func isL() -> Bool {
        let regex = try? NSRegularExpression(pattern: lCommandPattern)
        return isMatch(regex: regex, string: command)
    }
    
    private func isMatch(regex: NSRegularExpression?, string: String) -> Bool {
        let searchRange = NSMakeRange(0, string.count)
        let numberOfMatches = regex?.numberOfMatches(in: string, options: .reportProgress, range: searchRange)
        return numberOfMatches == 1
    }
    
}

