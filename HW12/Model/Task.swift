//
//  Task.swift
//  HW12
//
//  Created by Nur on 1/8/24.
//

import RealmSwift
import Foundation

class Task: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}
