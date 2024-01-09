//
//  Extention + TasksViewController.swift
//  HW12
//
//  Created by Nur on 1/9/24.
//

import UIKit
import RealmSwift

extension TasksViewController {
    func alertForAddAndUpdateList() {
        
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        var taskTextField: UITextField!
        var noteTextField: UITextField!
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let text = taskTextField.text , !text.isEmpty else { return }
            let note = noteTextField.text ?? ""
            self.savetask(title: text, note: note)
            self.refreshTasksFromDB()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        
        
        alert.addTextField { textField in
            taskTextField = textField
            taskTextField.placeholder = "Задаячв"
        }
        
        alert.addTextField { textField in
            noteTextField = textField
            noteTextField.placeholder = "Значение"
        }
        
        
        present(alert, animated: true)
    }
   
    func alertForConfigList() {
        
        let alert = UIAlertController(title: "Отсортировать?", message: "", preferredStyle: .alert)
        let sortByDate = UIAlertAction(title: "По дате", style: .default)
        let sortByAZ = UIAlertAction(title: "По алфовиту", style: .default)
        let cancel = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(sortByAZ)
        alert.addAction(sortByDate)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func filterTasksByComlition() {
        currentTasks = tasksList.filter("isComplete = false")
        completedTasks = tasksList.filter("isComplete = true")
        tableView.reloadData()
    }
    func savetask(title: String, note: String) {
        let mewTask = Task()
        mewTask.name = title
        mewTask.note = note
        taskArray.append(mewTask)
        DispatchQueue.main.async {
            StorageManager.saveTasksList(self.taskArray)
            print("Save is Done")
        }
    }
    func refreshTasksFromDB() {
        DispatchQueue.main.async {
            self.tasksList = realm.objects(Task.self)
            self.filterTasksByComlition()
            self.tableView.reloadData()
        }
    }
}
