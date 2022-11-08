//
//  RecordsTableViewController.swift
//  DailyRecords
//
//  Created by Sora on 31.10.2022.
//

import UIKit
import CoreData

class RecordsTableViewController: UITableViewController {
    
    let data = DataManipulation()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
        
        data.loadData(context: context)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data.loadData(context: context)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toEditSegue {
            let destinationVC = segue.destination as! EditViewController
            let record = sender as? Record
            destinationVC.record = record
        }
    }
    
}

// MARK: - Table View DataSource

extension RecordsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManipulation.recordsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = DataManipulation.recordsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellRecordID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(record.title ?? "1 op") - \(record.text ?? "Hello op")"
        cell.contentConfiguration = content
        
        return cell
    }
}

//MARK: - Table View Delegate

extension RecordsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record  = DataManipulation.recordsList[indexPath.row]
        performSegue(withIdentifier: K.toEditSegue, sender: record)
    }
}
