//
//  AddToBucketList.swift
//  BucketListIV
//
//  Created by admin on 23/05/1443 AH.
//

import UIKit

protocol BucketListDelegate: AnyObject{
    
    func itemSaved(with text: String, at indexPath: NSIndexPath?)
}

class AddToBucketList: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: BucketList?
    var item: String?
    var indexPath: IndexPath?
    var taskToEdit: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = taskToEdit?.value(forKey: "objective") as? String
        
    }
    // MARK: - Navigation
    
    
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        if let taskToEdit = taskToEdit, let objactiveString = textField.text{
            taskToEdit.setValue(textField.text ,forKey: "objective")
                TaskModel.updateTask(id: taskToEdit.value(forKey: "id") as! String , objective:  objactiveString, completionHandler:{ data, response, error in
                    if let data = data {
                        do{
                            let task = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            
                            DispatchQueue.main.async {
                                self.delegate?.itemsList[self.indexPath!.row] = task
                                self.delegate?.tableView.reloadData()
                                self.dismiss(animated: true, completion: nil)
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                })}
        else{
            
            addNewTask()
            
        }
      
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
     func addNewTask() {
        if let text = textField.text {
            TaskModel.addTask(objective: text) { data, response, error in
                if let data = data{
                    do{
                        let task = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                       
                            DispatchQueue.main.async {
                                self.delegate?.itemsList.append(task)
                                self.delegate?.tableView.reloadData()
                                self.navigationController?.popViewController(animated: true)
                            
                        }}
                    catch{
                        
                    }
                }
                else{
                    print("No response")
                }
            }
        }
    }
}
