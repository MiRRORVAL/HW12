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
            taskTextField.placeholder = "Имя"
        }
        alert.addTextField { textField in
            noteTextField = textField
            noteTextField.placeholder = "Значение"
        }

        present(alert, animated: true)
    }
   
//    func alertForConfigList() {
//        
//        let alert = UIAlertController(title: "Отсортировать?",
//                                      message: "",
//                                      preferredStyle: .alert)
//        let sortByDate = UIAlertAction(title: "По дате", style: .default)/* { _ in*/
//
//        let sortByAZ = UIAlertAction(title: "По алфовиту", style: .default) { _ in
//
//        }
//        let cancel = UIAlertAction(title: "Отмена", style: .destructive)
//        alert.addAction(sortByAZ)
//        alert.addAction(sortByDate)
//        alert.addAction(cancel)
//        present(alert, animated: true)
//    }
    
    func filterTasksByComlition() {
        currentTasks = tasksList.filter("isComplete = false")
        completedTasks = tasksList.filter("isComplete = true")
        tableView.reloadData()
    }
    func savetask(title: String, note: String) {
        let newTask = Task()
        newTask.name = title
        newTask.note = note
        DispatchQueue.main.async {
            StorageManager.saveTask(newTask)
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
    
    func showEditAlert(title: String, message: String, task: Task) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        var taskTextField: UITextField!
        var noteTextField: UITextField!
        let doneBatoneValue = task.isComplete == true ? "Не завершена" : "Завершена"

        let editAction = UIAlertAction(title: "Отредактировать", style: .default) { _ in
            guard let text = taskTextField.text, !text.isEmpty else { return }
            let note = noteTextField.text ?? ""
            
            StorageManager.editTask(task, text, note)
            self.refreshTasksFromDB()
        }

        let doneAction = UIAlertAction(title: doneBatoneValue, style: .default) { _ in
            StorageManager.taskIsDone(task)
            self.refreshTasksFromDB()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }

        alert.addAction(editAction)
        alert.addAction(doneAction)
        alert.addAction(cancel)
        alert.addTextField { textField in
            textField.text = task.name
            taskTextField = textField
        }
        alert.addTextField { textField in
            textField.text = task.note
            noteTextField = textField
        }
        
        present(alert, animated: true)
    }
}
