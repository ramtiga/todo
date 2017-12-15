//
//  ViewController.swift
//  CoreData2
//
//  Created by Dai Haneda on 2017/12/16.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var tasks : [Task] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getData()
    
    tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    let task = tasks[indexPath.row]
    
    if task.isimportant {
      cell.textLabel?.text = "★\(task.name!)"
    } else {
      cell.textLabel?.text = task.name
    }


    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    if editingStyle == .delete {
      let task = tasks[indexPath.row]
      context.delete(task)
      (UIApplication.shared.delegate as! AppDelegate).saveContext()
      
      do {
        tasks = try context.fetch(Task.fetchRequest())

      } catch {
        print("fetch error")
        
      }
      tableView.reloadData()
    }
  }
  
  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
      tasks = try context.fetch(Task.fetchRequest())
    } catch {
      print("fetch error")
    }

  }
}

