//
//  main.swift
//  Assembler
//
//  Created by Gustavo Pirela on 26/9/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

do {
    let manager = try IOManager()
    try manager.makeBinaryFile()
} catch IOError.wrongNumberOfArguments {
    print("The numbers of required arguments is 2")
    print("Usage: Assembler file.asm")
} catch IOError.wrongFileExtension {
    print("The file extension should be .asm")
} catch IOError.fileCanNotBeRead {
    print("The file couldn't be read")
}

