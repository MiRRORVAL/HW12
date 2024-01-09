//
//  TaskViewController.swift
//  HW12
//
//  Created by Nur on 1/8/24.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var tasksList: Results<Task>!
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksList = realm.objects(Task.self)
        filterTasksByComlition()
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        if editingStyle == .delete {
            StorageManager.deleteTask(task)
            refreshTasksFromDB()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        cell.textLabel?.textColor = indexPath.section == 0 ? .black : .lightGray
        cell.detailTextLabel?.textColor = indexPath.section == 0 ? .black : .lightGray
        
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.note
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = indexPath.section == 0 ?
        currentTasks[indexPath.item] : completedTasks[indexPath.item]
        showEditAlert(title: "Редактор",
                      message: "Что вы хотите сделать?",
                      task: task)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Текущие" : "Завершенные"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return section == 0 ? currentTasks.count : completedTasks.count
        }
    
//    @IBAction func editButtonPressed(_ sender: Any) {
//        alertForConfigList()
//    }
    
    @IBAction func  addButtonPressed(_ sender: Any) {
        alertForAddAndUpdateList()
    }
    
}


