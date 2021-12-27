//
//  ViewController.swift
//  BucketListIV
//
//  Created by admin on 23/05/1443 AH.
//

import UIKit

class BucketList: UITableViewController{
    
    var itemsList: [NSDictionary] = []
    var indexPath: IndexPath?
    
    
    struct taskCharacter {
        let createdAt: String
        var objective: String
        
        
        
        init?(dict: [String: Any]){
            guard let objective = dict["objective"] as? String,
                  let createdAt = dict["createdAt"] as? String else {
                      return nil
                  }
            
            self.createdAt = createdAt
            self.objective = objective
            
            
        }
    }
    
    override func viewDidLoad() {
        TaskModel.getAllTasks() {
            data, response, error in
            if let data = data{
            do {
                if let tasks = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    print(tasks)
                    for task in tasks{
                        self.itemsList.append(task as! NSDictionary)
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                            
                        }}
                }
            } catch {
                print("Something went wrong")
            }
            }}
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let navegation = segue.destination as! UINavigationController
            let addVC = navegation.topViewController as! AddToBucketList
            addVC.delegate = self
            if let newTask = sender as? NSMutableDictionary  {
                addVC.indexPath = self.indexPath
                addVC.taskToEdit = newTask
            }
           
        }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = ((itemsList[indexPath.row]["objective"]) as! String)

        cell.detailTextLabel?.text =  ((itemsList[indexPath.row]["createdAt"]) as! String)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            self.indexPath = indexPath
            performSegue(withIdentifier: "AddEditSegues", sender: itemsList[indexPath.row])
            
        }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            TaskModel.deleteTask(id: itemsList[indexPath.row]["id"] as! String, completionHandler:{ data, response, error in
                if data != nil {
                        DispatchQueue.main.async {
                            self.itemsList.remove(at: indexPath.row)
                            self.tableView.reloadData()
                        }
                }
            })
            
        }

    
    
    
}
