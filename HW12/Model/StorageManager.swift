//
//  StorageManager.swift
//  HW12
//
//  Created by Nur on 1/8/24.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveTasksList(_ tasksList: List<Task>) {
        try! realm.write {
            realm.add(tasksList)
        }
    }
}
