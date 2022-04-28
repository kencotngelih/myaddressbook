//
//  Note+CoreDataClass.swift
//  MyNotes
//
//  Created by Robby Suliantoro on 27/04/22.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
    }
    
    var desc: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        //return "\(lastUpdated.format()) \(lines.first ?? "")" // return second line
        return "\(lines.first ?? "")"
    }
}
