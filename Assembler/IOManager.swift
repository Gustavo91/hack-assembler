//
//  CommandLineIO.swift
//  Assembler
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

class IOManager {
    
    var argument: String?
    
    func readArgument() {
        guard CommandLine.argc == 2  else {
            handleError()
            return
        }
        
        argument = CommandLine.arguments[1]
        
        if !(argument!.contains(".asm")) {
            handleError()
        }
    }
    
    private func handleError() {
        print("Usage: assembler file.asm")
        argument = nil
    }
    
}
