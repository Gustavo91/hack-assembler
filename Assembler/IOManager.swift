//
//  CommandLineIO.swift
//  Assembler
//
//  Created by Gustavo Pirela on 29/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

enum IOError: Error {
    case wrongNumberOfArguments
    case wrongFileExtension
    case fileCanNotBeRead
}

class IOManager {
    
    let fileManager = FileManager.default
    var fileName: String
    
    init() throws {
        try fileName = IOManager.getFileNameFromStdIn()
    }
    
    func makeBinaryFile() throws {
        let assemblerUrl = makeFileUrl(fileExtension: "asm")
        let binaryUrl = makeFileUrl(fileExtension: "hack")
        let content = try getContentOf(file: assemblerUrl)
        let newContent = Parser.translate(assembly: content).trimmingCharacters(in: .whitespacesAndNewlines)
        try newContent.write(to: binaryUrl, atomically: true, encoding: .utf8)
    }
    
    // MARK: - Private
    
    private func getContentOf(file url: URL) throws -> String {
        guard let fileContent = try? String(contentsOf: url) else {
            throw IOError.fileCanNotBeRead
        }
        
        return fileContent.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func makeFileUrl(fileExtension: String) -> URL {
        let filePath = fileManager.currentDirectoryPath
        let fileUrl = URL(fileURLWithPath: filePath)
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        return fileUrl
    }
    
    private static func getFileNameFromStdIn() throws -> String {
        let numberOfArgument = CommandLine.argc
        guard numberOfArgument == 2 else {
            throw IOError.wrongNumberOfArguments
        }
        
        let argument = CommandLine.arguments[1]
        if !(argument.contains(".asm")) {
            throw IOError.wrongFileExtension
        }
        
        return argument.replacingOccurrences(of: ".asm", with: "")
    }
    
}
