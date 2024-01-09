//
//  TaskViewController.swift
//  HW12
//
//  Created by Nur on 1/8/24.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    var taskArray = List<Task>()
    
    var tasksList: Results<Task>!
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksList = realm.objects(Task.self)
        filterTasksByComlition()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        var task: Task!
        task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
       if indexPath.section == 0 {
           cell.textLabel?.textColor = .black
           cell.backgroundColor = .clear
       } else {
           cell.textLabel?.textColor = .darkGray
           cell.backgroundColor = .lightGray
       }
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.note
        
        return cell
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
    
    @IBAction func editButtonPressed(_ sender: Any) {
        alertForConfigList()
    }
    
    @IBAction func  addButtonPressed(_ sender: Any) {
        alertForAddAndUpdateList()
    }
    
}


