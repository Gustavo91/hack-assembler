//
//  Parser.swift
//  Assembler
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

class Parser {
    
    var currentCommand: Command!
    
    func commandType(for command: String) -> CommandType {
        let command = Command(command: command)
        return command.type
    }
    
}



