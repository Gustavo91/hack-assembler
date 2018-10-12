//
//  String+Split.swift
//  Assembler
//
//  Created by Gustavo Pirela on 10/10/2018.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

extension String {
    
    func getLines() -> [String] {
        var lines = [String]()
        self.enumerateLines { line, _ in
            if let comments = line.getMatch(pattern: "(//.*)", group: 1), comments != "NULL" {
                let lineWithoutComments = line.replacingOccurrences(of: comments, with: "")
                lines.append(lineWithoutComments.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                lines.append(line.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
        
        return lines
    }
    
    func getMatch(pattern: String, group: Int = 0) -> String? {
        let range = NSMakeRange(0, self.count)
        guard let regex = try? NSRegularExpression(pattern: pattern),
            let match = regex.firstMatch(in: self, options: .reportProgress, range: range) else {
                return nil
        }
        
        let matchRange = group == 0 ? match.range : match.range(at: group)
        let nsStringcommand = self as NSString
        
        if matchRange.length == 0 {
            return "NULL"
        }
        let stringMatched = nsStringcommand.substring(with: matchRange)
        return stringMatched
    }
    
    func hasMatch(regex: NSRegularExpression?) -> Bool {
        let searchRange = NSMakeRange(0, self.count)
        let numberOfMatches = regex?.numberOfMatches(in: self, options: .reportProgress, range: searchRange)
        return numberOfMatches == 1
    }

}
