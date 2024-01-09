//
//  StorageManager.swift
//  HW12
//
//  Created by Nur on 1/8/24.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveTask(_ task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    static func deleteTask(_ task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    static func editTask(_ task: Task, _ name: String, _ note: String) {
        try! realm.write {
            task.name = name
            task.note = note
        }
    }
    static func taskIsDone(_ task: Task) {
        try! realm.write {
            let trueSwitch = task.isComplete == true ? false : true
            task.isComplete = trueSwitch
        }
    }
}
