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
    case cCommand
    case lCommand
    case none
}

struct Command {
    
    // MARK: - Properties
    
    var command: String
    var type: CommandType { return getCommandType() }
    var symbol: String? { return type == .aCommand || type == .lCommand  ? getMatch(pattern: symbolPattern) : nil}
    var dest: String? { return type == .cCommand ? getMatch(pattern: destSymbolPattern) : nil}
    var comp: String? { return type == .cCommand ? getMatch(pattern: compPattern) : nil}
    var jump: String? { return type == .cCommand ? getMatch(pattern: jumpSymbolPattern) : nil}

    // MARK: - Init
    
    init(command: String) {
        self.command = command
    }
    
    // MARK: - Private
    
    private var aCommandPattern: String { return "^@\(symbolPattern)" }
    private var lCommandPattern: String { return "^\\(\(symbolPattern)\\)$" }
    private var cCommandPattern: String { return "^\(destPattern)\(compPattern)\(jumpPattern)$" }
    private var jumpPattern: String { return "(?:;\(jumpSymbolPattern))*" }
    private var destPattern: String { return "(?:\(destSymbolPattern)=)*" }
    private let symbolPattern = "[A-Za-z$:_][\\w$:_]*"
    private let jumpSymbolPattern = "J(?:GT|EQ|GE|LT|NE|LE|MP)+"
    private let destSymbolPattern = "[AMD]{1,3}"
    private let compPattern = "A[&\\+\\|\\-]D|D[&\\+\\|\\-]A|M[&\\+\\|\\-]D|D[&\\+\\|\\-]M|[AMD][\\+\\-]1|1\\+[AMD]|\\-[1AMD]|![AMD]|[01AMD]"

    private func getCommandType() -> CommandType {
        if isA() {
            return .aCommand
        } else if isC() {
            return .cCommand
        } else if isL() {
            return .lCommand
        } else {
            return .none
        }
    }
    
    private func getMatch(pattern: String) -> String? {
        let range = NSMakeRange(0, command.count)
        guard let regex = try? NSRegularExpression(pattern: pattern),
            let match = regex.firstMatch(in: command, options: .reportProgress, range: range) else {
                return nil
        }
        let matchRange = match.range
        let nsStringcommand = command as NSString
        return nsStringcommand.substring(with: matchRange)
    }
    
    private func isA() -> Bool {
        let regex = try? NSRegularExpression(pattern: aCommandPattern)
        return isMatch(regex: regex, string: command)
    }
    
    private func isC() -> Bool {
        let regex = try? NSRegularExpression(pattern: cCommandPattern)
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
    
    private func getCommandPattern() -> String {
        switch type {
        case .aCommand:
            return aCommandPattern
        case .lCommand:
            return lCommandPattern
        case .cCommand:
            return cCommandPattern
        default:
            return ""
        }
    }
}

